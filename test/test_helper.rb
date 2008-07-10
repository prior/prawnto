require 'rubygems'
require 'action_controller'
require 'test/unit'

module ApplicationHelper; end

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'prawn'

#TODO: figure out if mocha is really required-- what is the recommended way to test controller/view stuff in Rails 2.1?
# require 'mocha'
