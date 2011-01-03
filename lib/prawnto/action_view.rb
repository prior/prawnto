module Prawnto
  module ActionView

    def self.included(base)
      base.alias_method_chain :render, :prawnto
    end

    def render_with_prawnto(options = {}, local_assigns = {}, &block) #:nodoc:
      local_assigns ||= {}
      
      if template_format == :pdf && @pdf.nil?
        extend PrawntoLayoutHelpers
        _prawnto_compile_setup
        @pdf = Prawn::Document.new(@prawnto_options[:prawn])
        render_without_prawnto(options, local_assigns, &block)
        @pdf.render
      else
        render_without_prawnto(options, local_assigns, &block)
      end
    end

  private
    def _prawnto_compile_setup(dsl_setup = false)
      compile_support = Prawnto::TemplateHandler::CompileSupport.new(controller)
      @prawnto_options = compile_support.options
    end
    
    module PrawntoLayoutHelpers
      def content_for(name = :_action, &block)
        instance_variable_set("@content_for_#{name}", block)
        nil
      end
      
      def [](var)
        instance_variable_get(:"@#{var}")
      end
    end

  end
end

module Prawnto
  module Template
    def self.included(base)
      base.alias_method_chain :initialize, :prawnto
    end

    def initialize_with_prawnto(*args)
      initialize_without_prawnto(*args)
      if format.to_s == 'pdf'
        extend InstanceMethods
      end
    end
    
    module InstanceMethods
      def render(view, local_assigns = {})
        compile(local_assigns)

        view.with_template self do
          view.send(:_evaluate_assigns_and_ivars)
          view.send(:_set_controller_content_type, mime_type) if respond_to?(:mime_type)

          view.send(method_name(local_assigns), local_assigns) do |*names|
            ivar = :@_proc_for_layout
            if !view.instance_variable_defined?(:"@content_for_#{names.first}") && view.instance_variable_defined?(ivar) && (proc = view.instance_variable_get(ivar))
              view.capture(*names, &proc)
            elsif view.instance_variable_defined?(ivar = :"@content_for_#{names.first || :_action}")
              view.instance_variable_get(ivar).call(view.instance_variable_get(:@pdf))
            end
          end
        end
      end
    end
    
  end
end
