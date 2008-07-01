require 'prawn'

ActionView::Template.register_template_handler 'prawn', PrawnView::PrawnView
