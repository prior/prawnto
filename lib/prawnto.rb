$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'prawnto/railtie' if defined?(Rails)

module Prawnto
  VERSION='0.1.1'
  
  autoload :ActionControllerMixin, 'prawnto/action_controller_mixin'
  autoload :ActionViewMixin, 'prawnto/action_view_mixin'
  module TemplateHandlers
    autoload :Base, 'prawnto/template_handlers/base'
    autoload :Dsl, 'prawnto/template_handlers/dsl'
  end

  class << self
    
    # Register the MimeType and the two template handlers.
    def on_init
      Mime::Type.register "application/pdf", :pdf unless defined?(Mime::PDF)
      ActionView::Template.register_template_handler 'prawn', Prawnto::TemplateHandlers::Base
      ActionView::Template.register_template_handler 'prawn_dsl', Prawnto::TemplateHandlers::Dsl
    end
    
    # Include the mixins for ActionController and ActionView.
    def on_load
      ActionController::Base.send :include, Prawnto::ActionControllerMixin
      ActionView::Base.send :include, Prawnto::ActionViewMixin
    end
    
    # Runs the registration and include methods. This is used for testing only as railtie.rb usually runs these individually.
    def init_both
      on_init
      on_load
    end
    
  end

end
