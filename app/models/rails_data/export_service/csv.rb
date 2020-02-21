require 'csv'
class RailsData::ExportService::Csv
  include DataExportHelper

  attr_reader :sheet, :headers

  def initialize
    headers =
    config_table


  end


  

end
