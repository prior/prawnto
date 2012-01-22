require 'rubygems'
require 'spork'

Spork.prefork do
  # Configure Rails Environment
  ENV["RAILS_ENV"] = "test"

  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'rspec/rails'

  Rails.backtrace_cleaner.remove_silencers!

  # Load support files
  # Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  RSpec.configure do |config|
    config.mock_with :mocha

    config.infer_base_class_for_anonymous_controllers = false
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.

end
