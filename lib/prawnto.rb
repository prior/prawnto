$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Prawnto
  VERSION='0.0.5'
  autoload :ActionControllerMixin, 'prawnto/action_controller_mixin'
  autoload :ActionViewMixin, 'prawnto/action_view_mixin'
  module TemplateHandlers
    autoload :Base, 'prawnto/template_handlers/base'
    autoload :Dsl, 'prawnto/template_handlers/dsl'
  end

  module TemplateHandler
    autoload :CompileSupport, 'prawnto/template_handler/compile_support'
  end

  class << self
    def enable
      # ActionController::Base.send :include, Prawnto::ActionControllerMixin
      # ActionView::Base.send :include, Prawnto::ActionViewMixin
      
            
      ActiveSupport.on_load(:action_controller) do
        include Prawnto::ActionControllerMixin
      end
      
      ActiveSupport.on_load(:action_view) do
        include Prawnto::ActionViewMixin
      end
      

      Mime::Type.register "application/pdf", :pdf unless defined?(Mime::PDF)
      ActionView::Template.register_template_handler 'prawn', Prawnto::TemplateHandlers::Base
      ActionView::Template.register_template_handler 'prawn_dsl', Prawnto::TemplateHandlers::Dsl
    end
  end

  require "prawnto/railtie"
end

