require 'active_support/configurable'

module RailsData
  # Config
  # Configure the standard CSV default options
  # as well the option to output the header row

  include ActiveSupport::Configurable

  configure do |config|
    config.mapping = ActiveSupport::OrderedOptions.new

    config.inflector = :titleize
    config.method_name = :report
    config.mapping.date = { input: 'date', output: 'to_date' }
    config.mapping.integer = { input: 'number', output: 'to_i' }
    config.mapping.string = { input: 'text', output: 'to_s' }
    config.mapping.text = { input: 'textarea', output: 'to_s' }
    config.mapping.array = { input: 'array', output: 'to_s' }
  end

end
