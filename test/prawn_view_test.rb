require File.dirname(__FILE__) + '/test_helper'

class SomeController; end
module SomeHelper; end

class PrawnView::PrawnViewTest < Test::Unit::TestCase
  def test_should_not_be_compilable
    view = stub(:controller => SomeController.new)
    prawn_view = PrawnView::PrawnView.new(view)
    assert !prawn_view.compilable?
  end
  #TODO: add checks to make sure line_number reporting is good for errors-- even when document options are included (in document_options = and in rest of view)
  #TODO: add checks to make sure options setting is working properly
  #TODO: add checks to make sure controller variables are available as well as helper functions as well as local variables
  #TODO: partial possibilities?
end
