require 'csv'
module Datum
  class CsvExporter < BaseExporter

    def run
      csv = ''

      csv << headers.to_csv
      @export.collection.call(@params).each_with_index do |object, index|
        row = field_result(object, index)
        csv << row.to_csv
      end

      csv
    end

  end
end
