Gem::Specification.new do |s|
  s.name = 'rails_data'
  s.version = '1.0.2'
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

  s.add_dependency 'rails_extend'
  s.add_dependency 'write_xlsx'
  s.add_dependency 'roo'
  s.add_dependency 'roo-xls'
  s.add_dependency 'prawn'
  s.add_dependency 'prawn-table'
  s.add_dependency 'matrix'
end
