require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe TestController do
  
  describe "GET default_render" do
    it "returns correct PDF" do
      get "/default_render.pdf"
      response.should be_success
      
      asset_binary = File.open(TEST_ASSETS + "/default_render.pdf").read.bytes.to_a
      body_binary = response.body.bytes.to_a
      body_binary.should == asset_binary
    end
  end
  
  
  describe "GET dsl_render" do
    it "returns correct PDF" do
      get "/dsl_render.pdf"
      response.should be_success
      
      asset_binary = File.open(TEST_ASSETS + "/dsl_render.pdf").read.bytes.to_a
      body_binary = response.body.bytes.to_a
      body_binary.should == asset_binary
    end
  end
  
end