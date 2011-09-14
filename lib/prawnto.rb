$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'prawnto/railtie' if defined?(Rails)

module Prawnto
  VERSION='0.0.11'
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
    
    def run_includes
      ActionController::Base.send :include, Prawnto::ActionControllerMixin
      ActionView::Base.send :include, Prawnto::ActionViewMixin
    end
    
    def register_handlers
      Mime::Type.register "application/pdf", :pdf unless defined?(Mime::PDF)
      ActionView::Template.register_template_handler 'prawn', Prawnto::TemplateHandlers::Base
      ActionView::Template.register_template_handler 'prawn_dsl', Prawnto::TemplateHandlers::Dsl
    end
    
    def init_both
      run_includes
      register_handlers
    end
    
  end

end
