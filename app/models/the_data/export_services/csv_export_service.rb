require 'csv'
class CsvExportService
  include DataExportHelper

  attr_reader :sheet, :headers

  def initialize
    headers =
    config_table


  end


  def to_csv
    csv = ''
    csv << headers.to_csv
    self.table_items.each do |table_item|
      csv << table_item.fields.to_csv
    end
    csv
  end

end