$:.push File.expand_path('lib', __dir__)
require 'rails_data/version'

Gem::Specification.new do |s|
  s.name = 'rails_data'
  s.version = RailsData::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_data'
  s.summary = 'Data Import & Export for Rails'
  s.description = '数据导出，导入'
  s.license = 'MIT'

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
  s.add_dependency 'write_xlsx'
  s.add_dependency 'roo'
  s.add_dependency 'roo-xls'
  s.add_dependency 'prawn'
  s.add_dependency 'prawn-table'
end
