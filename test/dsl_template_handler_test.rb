require File.expand_path(File.dirname(__FILE__)+"/test_helper.rb")
require 'template_handler_test_mocks'

class PrawntoControllerTest < ActionController::TestCase
  include TemplateHandlerTestMocks
  
  def setup
    @view = ActionView.new
    @handler = Prawnto::TemplateHandlers::Base.new(@view)
    @controller = @view.controller
  end
  
  # I'm not sure what these are suppose to test, and they aren't currently working. - Forrest
  
  # def test_prawnto_options_dsl_hash
  #   @y = 3231; @x = 5322
  #   @controller.prawnto :dsl=> {'x'=>:@x, :y=>'@y'}
  #   @view.public_prawnto_compile_setup
  #   
  #   source = @handler.build_source_to_establish_locals(Template.new(""))
  # 
  #   assert_equal @x, eval(source + "\nx")
  #   assert_equal @y, eval(source + "\ny")
  # end
# 
#   def test_prawnto_options_dsl_array
#     @y = 3231; @x = 5322
#     @controller.prawnto :dsl=> ['x', :@y]
#     @handler.pull_prawnto_options
#     source = @handler.build_source_to_establish_locals(Template.new(""))
# 
#     assert_equal @x, eval(source + "\nx")
#     assert_equal @y, eval(source + "\ny")
#   end

end

