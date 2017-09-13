require 'active_support/configurable'

module TheData
  # Config
  # Configure the standard CSV default options
  # as well the option to output the header row

  include ActiveSupport::Configurable

  configure do |config|
    config.inflector = :titleize
    config.method_name = :report
    config.admin_class = 'Admin::BaseController'
    config.mapping = {
      date: { input: 'date', output: 'to_date' },
      integer: { input: 'number', output: 'to_i' },
      string: { input: 'text', output: 'to_s' },
      text: { input: 'textarea', output: 'to_s' }
    }
  end

end