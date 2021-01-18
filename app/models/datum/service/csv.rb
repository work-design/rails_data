require 'csv'
module Datum
  class Service::Csv
    attr_reader :sheet, :headers

    def initialize
      headers =
      config_table
    end

  end
end
