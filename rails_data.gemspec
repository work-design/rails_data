$:.push File.expand_path('lib', __dir__)
require 'rails_data/version'

Gem::Specification.new do |s|
  s.name = 'rails_data'
  s.version = RailsData::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_data'
  s.summary = 'Data Import & Export for Rails'
  s.description = 'Description of RailsData.'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir[
    'test/**/*'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_dependency 'write_xlsx', '~> 0.83.0'
  s.add_dependency 'roo', '~> 2.7'
  s.add_dependency 'roo-xls', '~> 1.2'
  s.add_dependency 'prawn', '~> 2.2'
  s.add_dependency 'prawn-table', '~> 0.2'
end
