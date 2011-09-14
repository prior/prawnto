$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'tempfile'

require 'active_support'
require 'action_controller'
require 'action_view'

require 'test/unit'

require File.join(File.dirname(__FILE__), '/../lib/prawnto.rb')
Prawnto.init_both

class PrawntoController < ActionController::Base
end