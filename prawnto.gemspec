require File.expand_path(File.join(File.dirname(__FILE__),"lib/prawnto.rb"))

Gem::Specification.new do |s|
  s.name = "prawnto"
  s.version = Prawnto::VERSION
  s.author = ["smecsia", "Forrest"]
  s.email = ["smecsia@gmail.com", "development@forrestzeisler.com"]
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  
  s.summary = "Prawnto rails plugin implemented as a gem (see prawnto)"
  s.description = '2011-2'
  s.homepage = "http://cracklabs.com/prawnto"

  s.required_rubygems_version = ">= 1.3.6"
  s.platform = Gem::Platform::RUBY
  s.add_dependency('rails', '>=3.1')
  s.add_dependency('prawn', '>= 0.12.0')

  s.files =   %w(lib/prawnto
              lib/prawnto/action_controller_mixin.rb
              lib/prawnto/action_view_mixin.rb
              lib/prawnto/railtie.rb
              lib/prawnto/template_handler
              lib/prawnto/template_handler/compile_support.rb
              lib/prawnto/template_handlers
              lib/prawnto/template_handlers/base.rb
              lib/prawnto/template_handlers/dsl.rb
              lib/prawnto.rb
              MIT-LICENSE
              rails/init.rb
              Rakefile
              README.rdoc
              test
              test/action_controller_test.rb
              test/base_template_handler_test.rb
              test/dsl_template_handler_test.rb
              test/template_handler_test_mocks.rb)
  
  s.require_paths = ["lib"]

  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
end