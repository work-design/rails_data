module RailsData
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/rails_data",
      "#{config.root}/app/models/rails_data/concerns",
      "#{config.root}/app/models/rails_data/data_lists",
      "#{config.root}/app/models/rails_data/export_services"
    ]

    initializer 'rails_data.assets.precompile' do |app|
      app.config.assets.precompile += ['rails_data_manifest.js']
      Mime::Type.register 'application/xlsx', :xlsx
    end

  end
end

