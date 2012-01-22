require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe TestController do
  
  describe "GET default_render" do
    it "returns hello_world.pdf" do
      get "/default_render.pdf"
      response.should be_success
      
      asset_binary = File.open(TEST_ASSETS + "/hello_world.pdf").read.bytes.to_a
      body_binary = response.body.bytes.to_a
      body_binary.should == asset_binary
    end
  end
  
  
end