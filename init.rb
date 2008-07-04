require 'prawn_view'

Mime::Type.register "application/pdf", :pdf
ActionView::Template.register_template_handler :prawn, PrawnView::Prawn

