require File.dirname(__FILE__) + '/test_helper'

class SomeController; end
module SomeHelper; end

class PrawnView::PrawnViewTest < Test::Unit::TestCase
  def test_should_not_be_compilable
    view = stub(:controller => SomeController.new)
    prawn_view = PrawnView::PrawnView.new(view)
    assert !prawn_view.compilable?
  end
end
