require File.expand_path(File.dirname(__FILE__)+"/test_helper.rb")

class PrawntoControllerTest < ActionController::TestCase
  
  class PrawntoControllerWithInlineTrue < PrawntoController
    prawnto :inline=>true, :prawn=>{:page_orientation=>:landscape}
  end
  
  class PrawntoControllerWithInlineFalse < PrawntoController
    prawnto :inline=>false
  end
  

  def test_inheritable_options
    assert_equal({:page_orientation=>:landscape}, PrawntoControllerWithInlineTrue.prawn_hash)
    assert_equal({:inline=>true}, PrawntoControllerWithInlineTrue.prawnto_hash)
    
    #send a change and make sure it doesn't effect the others
    @controller.send(:prawnto, {:inline=>false})
    assert_equal({:inline=>false, :prawn => {}}, @controller.send(:compute_prawnto_options))
    assert_equal({:inline=>true, :prawn=>{:page_orientation=>:landscape}}, PrawntoControllerWithInlineTrue.new.send(:compute_prawnto_options))
  end

  def test_computed_options
    # controller = PrawntoController.new
    @controller.send(:prawnto, {:inline=>false, :prawn=>{:page_orientation=>:landscape, :page_size=>'A4'}})
    assert_equal({:inline=>false, :prawn=>{:page_orientation=>:landscape, :page_size=>'A4'}}, @controller.send(:compute_prawnto_options))
  end


  def test_default_settings
    # controller = PrawntoController.new
    assert_equal({:inline=>true, :prawn => {}}, @controller.send(:compute_prawnto_options))
  end
  
end

