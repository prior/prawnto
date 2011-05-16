require 'prawnto'

Mime::Type.register "application/pdf", :pdf unless Mime::PDF
ActionView::Template.register_template_handler 'prawn', Prawnto::TemplateHandlers::Base
ActionView::Template.register_template_handler 'prawn_dsl', Prawnto::TemplateHandlers::Dsl
ActionView::Template.register_template_handler 'prawn_xxx', Prawnto::TemplateHandlers::Raw  

