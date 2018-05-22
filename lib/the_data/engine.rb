module TheData
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/the_data",
      "#{config.root}/app/models/the_data/concerns",
      "#{config.root}/app/models/the_data/data_lists"
    ]

    initializer 'the_data.assets.precompile' do |app|
      app.config.assets.precompile += ['the_data_manifest.js']
      Mime::Type.register 'application/xlsx', :xlsx
    end

  end
end

