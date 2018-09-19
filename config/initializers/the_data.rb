require 'csv'
RailsData::Engine.config.paths['config/locales'].expanded.each do |path|
  Rails.configuration.paths['config/locales'].push(path)
end