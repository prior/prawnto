class PdfController < ApplicationController
  def index
  end
  
  def controller_variables
    @text = "Hello Controller Variables"
  end

  def landscape
    @prawn_document_options = {:page_layout => :landscape}
  end

  def a4
    @prawn_document_options = {:page_size => 'A4'}
  end

  def thick_margins
    @prawn_document_options = {:left_margin=>150,
                     :right_margin=>150,
                     :top_margin=>300,
                     :bottom_maring=>300}
  end

  def russian_boxes
    @prawn_document_options = {:page_layout => :landscape}
  end

end
