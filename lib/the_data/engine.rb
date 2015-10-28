require 'rubygems'
require 'prawn/table'
require 'refile'
require 'refile/rails'
require 'sprockets/railtie'

module TheData
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    #config.assets.precompile += ['one_report/application.js']
    #config.assets.precompile += ['one_report/application.css']
  end
end

