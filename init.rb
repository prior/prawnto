require 'prawnto'

Mime::Type.register "application/pdf", :pdf
ActionView::Template.register_template_handler :prawn, Prawnto::Prawn

