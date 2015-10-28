$:.push File.expand_path("../lib", __FILE__)

require 'the_data/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_data"
  s.version     = TheData::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = "https://github.com/yigexiangfa/the_data"
  s.summary     = "Summary of TheData."
  s.description = "Description of TheData."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency 'refile'
  s.add_dependency 'prawn-table'
end
