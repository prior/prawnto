
Gem::Specification.new do |s|
  s.name = "prawnto_2"
  s.version = '0.2.1'
  s.author = ["Forrest"]
  s.email = ["development@forrestzeisler.com"]
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  
  
  s.description = 'Simple PDF generation using the prawn library.'
  s.summary = "This gem allows you to use the PDF mime-type and the simple prawn syntax to generate impressive looking PDFs."
  
  # s.homepage = "http://cracklabs.com/prawnto"

  s.required_rubygems_version = ">= 1.3.6"
  s.platform = Gem::Platform::RUBY
  s.add_dependency('rails', '>= 3.1')
  s.add_dependency('prawn', '>= 0.6.0')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path  = "lib"
  
  
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
end
