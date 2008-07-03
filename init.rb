require 'prawn_view'

ActionView::Template.register_template_handler :prawn, PrawnView::PrawnView
