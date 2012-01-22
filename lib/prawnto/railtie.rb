module Prawnto
  class Railtie < Rails::Railtie

    # This runs once during initialization.
    # Register the MimeType and the two template handlers.
    initializer "prawnto.register_handlers" do
      Mime::Type.register("application/pdf", :pdf) unless Mime::Type.lookup_by_extension(:pdf)
      # ActionView::Template.register_template_handler 'pdf.prawn', Prawnto::TemplateHandlers::Base
      ActionView::Template.register_template_handler 'prawn', Prawnto::TemplateHandlers::Base
      ActionView::Template.register_template_handler 'prawn_dsl', Prawnto::TemplateHandlers::Dsl
    end
    
    # This will run it once in production and before each load in development.
    # Include the mixins for ActionController and ActionView.
    config.to_prepare do
      ActionController::Base.send :include, Prawnto::ActionControllerMixin
      ActionView::Base.send :include, Prawnto::ActionViewMixins::ActionViewMixin
    end
    
  end
end