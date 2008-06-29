require 'railspdf'

ActionView::Template.register_template_handler 'rpdf', RailsPDF::PDFRender