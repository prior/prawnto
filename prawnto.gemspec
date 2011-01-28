spec = Gem::Specification.new do |s|
  s.name =    "prawnto"
  s.version = "0.0.3" #Not sure what the version number should be...
  s.summary =  "A rails plugin leveraging the new prawn library to produce compiled pdf views."
  s.files = %w(lib/prawnto
               lib/prawnto/action_controller.rb
               lib/prawnto/action_view.rb
               lib/prawnto/template_handler
               lib/prawnto/template_handler/compile_support.rb
               lib/prawnto/template_handlers
               lib/prawnto/template_handlers/base.rb
               lib/prawnto/template_handlers/dsl.rb
               lib/prawnto/template_handlers/raw.rb
               lib/prawnto.rb
               MIT-LICENSE
               rails/init.rb
               Rakefile
               README
               tasks
               tasks/prawnto_tasks.rake
               test
               test/action_controller_test.rb
               test/base_template_handler_test.rb
               test/dsl_template_handler_test.rb
               test/raw_template_handler_test.rb
               test/template_handler_test_mocks.rb)
  s.add_dependency "prawn", [">= 0.7.1", "< 0.8"]
end
