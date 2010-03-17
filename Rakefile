require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Default: run unit tests.'
task :default => :test

#desc 'Test the prawnto plugin.'
#Rake::TestTask.new(:test) do |t|
  #t.libs << 'lib'
  #t.pattern = 'test/**/*_test.rb'
  #t.verbose = true
#end

desc 'Generate documentation for the prawnto plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Prawnto'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PKG_FILES = FileList[ '[a-zA-Z]*',  'lib/**/*', 'test/*', 'rails/*' ]

spec = Gem::Specification.new do |s|
  s.name = "prawnto"
  s.version = "0.0.1"
  s.author = "smecsia"
  s.email = "smecsia@gmail.com"
  #s.homepage = ""
  s.platform = Gem::Platform::RUBY
  s.summary = "Prawnto rails plugin implemented as a gem (see prawnto)"
  s.add_dependency('rails', '>=2.1')
  s.add_dependency('prawn')
  s.files = PKG_FILES.to_a 
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

