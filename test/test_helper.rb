require 'rubygems'
require 'action_controller'
require 'test/unit'

module ApplicationHelper; end

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'railspdf'
require 'mocha'