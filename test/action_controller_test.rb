require 'rubygems'
require 'action_controller'
require 'action_view'

require 'test/unit'
require File.dirname(__FILE__) + '/../lib/prawnto'


class ActionControllerTest < Test::Unit::TestCase

  def setup
    @controller_class = Class.new(ActionController::Base)

    # for some reason using the following as a block in the preceding statement is somehow different?
    @controller_class.module_eval do
      prawnto :inline=>true, :prawn=>{:page_orientation=>:landscape}

      def test
        prawnto :inline=>false, :prawn=>{:page_size=>'A4'}
      end
    end
  end

  def test_inheritable_options
    assert_equal({:page_orientation=>:landscape}, @controller_class.read_inheritable_attribute(:prawn))
    assert_equal({:inline=>true}, @controller_class.read_inheritable_attribute(:prawnto))
  end

  def test_computed_options
    controller = @controller_class.new
    controller.test
    assert_equal({:inline=>false, :prawn=>{:page_orientation=>:landscape, :page_size=>'A4'}}, controller.send(:compute_prawnto_options))
  end

end

