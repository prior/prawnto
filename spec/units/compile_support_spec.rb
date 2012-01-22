require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe Prawnto::ActionViewMixins::CompileSupport do
  
  before do
    @request = mock()
    @request.stubs(:ssl?).returns(false)
    @headers = mock()
    @controller = mock()
    @controller.stubs(:request).returns(@request)
    @controller.stubs(:headers).returns(@headers)
    @controller.stubs(:compute_prawnto_options).returns({:inline => true})
  end

  describe "#set_disposition" do
    before do
      Prawnto::ActionViewMixins::CompileSupport.any_instance.stubs(:set_pragma).returns(true)
      Prawnto::ActionViewMixins::CompileSupport.any_instance.stubs(:set_cache_control).returns(true)
      Prawnto::ActionViewMixins::CompileSupport.any_instance.stubs(:set_content_type).returns(Mime::PDF)
    end
    
    it "default" do
      @headers.expects("[]=").with("Content-Disposition", "inline").once
      Prawnto::ActionViewMixins::CompileSupport.new(@controller)
    end

    it "inline with filename" do
      @controller.stubs(:compute_prawnto_options).returns({:filename => "xxx.pdf", :inline => true})
      @headers.expects("[]=").with("Content-Disposition", "inline;filename=\"xxx.pdf\"").once
      Prawnto::ActionViewMixins::CompileSupport.new(@controller)
    end
    
    it "attachment with filename" do
      @controller.stubs(:compute_prawnto_options).returns({:filename => "xxx.pdf", :inline => false})
      @headers.expects("[]=").with("Content-Disposition", "attachment;filename=\"xxx.pdf\"").once
      Prawnto::ActionViewMixins::CompileSupport.new(@controller)
    end

  end
  
  describe "#set_pragma" do
    pending
  end
  
  describe "#set_cache_control" do
    pending
  end

end

