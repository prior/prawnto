require File.dirname(__FILE__) + '/test_helper'

class SomeController; end
module SomeHelper; end

class RailsPDF::PDFRenderTest < Test::Unit::TestCase
  def test_should_not_be_compilable
    view = stub(:controller => SomeController.new)
    pdf = RailsPDF::PDFRender.new(view)
    assert !pdf.compilable?
  end
end
