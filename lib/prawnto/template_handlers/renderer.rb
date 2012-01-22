module Prawnto
  module TemplateHandlers
    class Renderer
      def initialize(view_context, calling_object = nil)
        @view_context = view_context
        @calling_object = calling_object
        set_instance_variables
        @pdf = Prawn::Document.new(@prawnto_options[:prawn]);
      end
      
      def to_pdf(&block)
        instance_eval(&block)
        @pdf.render.html_safe
      end
    
    private
    
      def set_instance_variables
        @calling_object ||= @view_context
        copy_instance_variables_from @calling_object
        
        if @prawnto_options[:instance_variables_from]
          copy_instance_variables_from @prawnto_options[:instance_variables_from]
        end
      end
    
      def pdf
        @pdf
      end
    
      # This was removed in Rails 3.1
      def copy_instance_variables_from(object, exclude = [])
        vars = object.instance_variables.map(&:to_s) - exclude.map(&:to_s)
        vars.each { |name| instance_variable_set(name, object.instance_variable_get(name)) }
      end
   
      def method_missing(m, *args)
        begin
          super
        rescue
          if pdf.respond_to?(m.to_s)
            pdf.send(m, *args)
          elsif @calling_object.respond_to?(m.to_s)
            @calling_object.send(m, *args)
          elsif @calling_object != @view_context and @view_context.respond_to?(m.to_s)
            @view_context.send(m, *args)
          else
            raise
          end
        end
      end
  
    end
  end
end
  