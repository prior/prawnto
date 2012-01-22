require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe TestController do
  
  class FakeView
    include Prawnto::ActionViewMixin
    attr_accessor :controller, :header
    def public_prawnto_compile_setup
      _prawnto_compile_setup
    end
  end
  
  before do
    @request = mock()
    @request.stubs(:ssl?).returns(false)
    @headers = mock()
    
    @controller = TestController.new
    @view = FakeView.new
    @view.controller = @controller
    @controller.stubs(:request).returns(@request)
    @controller.stubs(:headers).returns(@headers)
  end

  describe "#set_disposition" do
    before do
      @controller.stubs(:set_pragma).returns(true)
      @controller.stubs(:set_cache_control).returns(true)
      @controller.stubs(:set_content_type).returns(Mime::PDF)
    end
    
    it "default" do
      @headers.expects("[]=").with("Content-Disposition", "inline").once
      @view.public_prawnto_compile_setup
    end

    it "inline with filename" do
      @controller.prawnto :filename=>'xxx.pdf', :inline=>true
      @headers.expects("[]=").with("Content-Disposition", "inline;filename=\"xxx.pdf\"").once
      @view.public_prawnto_compile_setup
    end
    
    it "attachment with filename" do
      @controller.prawnto :filename=>'xxx.pdf', :inline=>false
      @headers.expects("[]=").with("Content-Disposition", "attachment;filename=\"xxx.pdf\"").once
      @view.public_prawnto_compile_setup
    end

  end
  
  describe "#set_pragma" do
    pending
  end
  
  describe "#set_cache_control" do
    pending
  end

end

