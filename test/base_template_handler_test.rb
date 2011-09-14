require File.expand_path(File.dirname(__FILE__)+"/test_helper.rb")
require 'template_handler_test_mocks'

class PrawntoControllerTest < ActionController::TestCase
  include TemplateHandlerTestMocks
  
  def setup
    @view = ActionView.new
    @handler = Prawnto::TemplateHandlers::Base.new(@view)
    @controller = @view.controller
  end

  def test_headers_disposition_inline_and_filename
    @controller.prawnto :filename=>'xxx.pdf', :inline=>true
    @view.public_prawnto_compile_setup
    
    assert_equal 'inline;filename="xxx.pdf"', @view.headers['Content-Disposition']
  end

  def test_headers_disposition_attachment_and_filename
    @controller.prawnto :filename=>'xxx.pdf', :inline=>false
    @view.public_prawnto_compile_setup
    
    assert_equal 'attachment;filename="xxx.pdf"', @view.headers['Content-Disposition']
  end
  
  def test_headers_disposition_default
    @view.public_prawnto_compile_setup
    
    assert_equal 'inline', @view.headers['Content-Disposition']
  end

end

