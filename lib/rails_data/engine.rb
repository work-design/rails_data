module RailsData
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/data_list"
    ]

    initializer 'rails_data.assets.precompile' do |app|
      app.config.assets.precompile += ['rails_data_manifest.js']
      Mime::Type.register 'application/xlsx', :xlsx
    end

  end
end

