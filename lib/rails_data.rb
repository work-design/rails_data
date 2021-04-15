require 'rails_data/engine'
require 'rails_data/config'
require 'rails_data/export'
require 'rails_data/import'
require 'rails_data/record'

module Datum

  def self.use_relative_model_naming?
    true
  end

end
