module RailsData
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/data_list"
    ]

    initializer 'rails_data.mime_type' do |app|
      Mime::Type.register 'application/xlsx', :xlsx
      Mime::Type.register 'application/xlsx', :excel
    end

  end
end

