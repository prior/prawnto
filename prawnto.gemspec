Gem::Specification.new do |s|
  s.name = %q{prawnto}
  s.version = "2.0.1"
  s.required_rubygems_version = ">= 1.3.6"

  s.authors = ['Some Body']
  s.email   = ['some@body.com']
  s.date = '2011-09-13'

  s.homepage = %q{http://github.com/fzeisler/prawnto}
  s.summary = %q{PDF views}
  s.description = %q{PDF views}

  exclude_folders = 'spec/rails/{doc,lib,log,nbproject,tmp,vendor,test}'
  exclude_files = Dir['**/*.log'] + Dir[exclude_folders+'/**/*'] + Dir[exclude_folders]
  s.files = Dir['{examples,lib,tasks,spec}/**/*'] -
    exclude_files
  s.require_paths = ["lib"]
  
  s.add_dependency('prawn', '>= 0.12.0')
end
