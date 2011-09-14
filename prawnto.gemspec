require File.join(File.dirname(__FILE__),"lib/prawnto.rb")

Gem::Specification.new do |s|
  s.name = "prawnto"
  s.version = Prawnto::VERSION
  s.author = "smecsia"
  s.email = "smecsia@gmail.com"
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  
  s.summary = "Prawnto rails plugin implemented as a gem (see prawnto)"
  s.description = '2011-2'
  s.homepage = "http://cracklabs.com/prawnto"

  s.required_rubygems_version = ">= 1.3.6"
  s.platform = Gem::Platform::RUBY
  s.add_dependency('rails', '>=3.1')
  s.add_dependency('prawn', '>= 0.12.0')

  exclude_folders = 'spec/rails/{doc,lib,log,nbproject,tmp,vendor,test}'
  exclude_files = Dir['**/*.log'] + Dir[exclude_folders+'/**/*'] + Dir[exclude_folders]
  s.files = Dir['{examples,lib,tasks,spec}/**/*'] - exclude_files
  s.require_paths = ["lib"]

  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
end