require 'rake'
require 'rake/testtask'
require 'rdoc/task'  


desc 'Default: run unit tests.'
task :default => :test

desc 'Generate documentation for the prawnto plugin.'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Prawnto'

  rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end

desc 'Test the prawnto gem'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end