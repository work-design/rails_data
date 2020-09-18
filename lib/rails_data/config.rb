require 'active_support/configurable'

module RailsData
  # Config
  # Configure the standard CSV default options
  # as well the option to output the header row
  include ActiveSupport::Configurable

  configure do |config|
    config.inflector = :titleize
    config.method_name = :report
  end

end
