module TheData
  class Engine < ::Rails::Engine

    initializer 'the_data.assets.precompile' do |app|
      app.config.assets.precompile += ['the_data_manifest.js']
    end

  end
end

