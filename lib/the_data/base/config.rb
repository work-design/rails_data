require 'active_support/configurable'

module TheData
  # Config
  # Configure the standard CSV default options
  # as well the option to output the header row

  include ActiveSupport::Configurable

  configure do |config|
    config.inflector = :titleize
  end

end
