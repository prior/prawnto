require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe TestController do
  
  class PrawntoControllerWithInlineTrue < TestController
    prawnto :inline=>true, :prawn=>{:page_orientation=>:landscape}
  end
  
  it "Controller should start with the defaults" do
    @controller = TestController.new
    @controller.send(:compute_prawnto_options).should == {:inline=>true, :prawn => {}}
  end

  describe ".prawnto" do
    it "should store prawn_hash" do
      PrawntoControllerWithInlineTrue.prawn_hash.should == {:page_orientation=>:landscape}
    end
    
    it "should store prawnto_hash" do
      PrawntoControllerWithInlineTrue.prawnto_hash.should == {:inline=>true}
    end
  end
  
  describe "#prawnto" do
    before do
      @controller = TestController.new
      @controller.send(:prawnto, {:inline=>false})
    end
    
    it "should affect that controller" do
      @controller.send(:compute_prawnto_options).should == {:inline=>false, :prawn => {}}
    end
    
    it "should not affect the controller class" do
      PrawntoControllerWithInlineTrue.new.send(:compute_prawnto_options).should == {:inline=>true, :prawn=>{:page_orientation=>:landscape}}
    end
  end

  describe "#compute_prawnto_options" do
    it "should merge the class settings and the instance settings" do
      @controller = TestController.new
      @controller.send(:prawnto, {:inline=>false, :prawn=>{:page_orientation=>:landscape, :page_size=>'A4'}})
      @controller.send(:compute_prawnto_options).should == {:inline=>false, :prawn=>{:page_orientation=>:landscape, :page_size=>'A4'}}
    end
  end

end

