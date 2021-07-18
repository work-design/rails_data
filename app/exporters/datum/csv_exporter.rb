require 'csv'
module Datum
  class CsvExporter
    attr_reader :sheet, :headers

    def initialize
      headers =
      config_table
    end

  end
end
