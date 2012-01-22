require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe SuperModel do
  
  describe "#to_pdf" do
    before do
      @model = SuperModel.new
    end
    
    it do
      asset_binary = File.open(TEST_ASSETS + "/default_render.pdf").read.bytes.to_a
      @model.to_pdf.bytes.to_a.should == asset_binary
    end
  end
  
end
