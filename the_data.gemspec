$:.push File.expand_path('../lib', __FILE__)
require 'the_data/version'

Gem::Specification.new do |s|
  s.name = 'the_data'
  s.version = TheData::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/yigexiangfa/the_data'
  s.summary     = "Summary of TheData."
  s.description = "Description of TheData."
  s.license = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 5.0'
  s.add_dependency 'write_xlsx', '~> 0.83.0'
  s.add_dependency 'roo'
  s.add_dependency 'roo-xls'
end
