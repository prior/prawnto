require 'test/unit'
require File.dirname(__FILE__) + '/template_handler_test_mocks'
require File.dirname(__FILE__) + '/../lib/prawnto'
require File.dirname(__FILE__) + '/../init'


#TODO: ruby1.9: pull same testing scheme from Raw once we're on 1.9
class BaseTemplateHandlerTest < Test::Unit::TestCase
  include TemplateHandlerTestMocks
  
  def setup
    @view = ActionView.new
    @handler = Prawnto::TemplateHandler::Base.new(@view)
  end


  def test_prawnto_options_dsl_hash
    x_value = 3231
    y_value = 5322
    x_grab = 0
    @view.instance_eval do
      @x = x_value
      @y = y_value
    end
    @view.controller.prawnto_options.merge! :dsl=>{'x'=>:@x, :y=>'@y'}
    source = @handler.compile(Template.new(""))
    @view.instance_eval source+"\nx_grab = x\n", "base.rb", 22
    assert_equal x_value, x_grab
    assert_equal y_value, y
  end

  def test_prawnto_options_dsl_array
  end

end

