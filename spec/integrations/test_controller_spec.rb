require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe TestController do
  
  describe "simple" do
    it "returns correct PDF" do
      get "/default_render.pdf"
      response.should be_success
      
      asset_binary = File.open(TEST_ASSETS + "/default_render.pdf").read.bytes.to_a
      body_binary = response.body.bytes.to_a
      body_binary.should == asset_binary
    end
  end
  
  
  describe "dsl" do
    it "returns correct PDF" do
      get "/dsl_render.pdf"
      response.should be_success
      
      asset_binary = File.open(TEST_ASSETS + "/dsl_render.pdf").read.bytes.to_a
      body_binary = response.body.bytes.to_a
      body_binary.should == asset_binary
    end
  end
  
  it "uses changed instance values in helpers" do
    expect { get "/complex.pdf" }.should_not raise_error
  end
  
end