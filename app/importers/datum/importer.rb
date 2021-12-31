require 'roo'
module Datum
  class Importer
    attr_reader :sheet, :column_index

    def initialize(table_list)
      @table_list = table_list
      @sheet_file = table_list.file
      if sheet_file.filename.extension == '.xls'
        require 'roo-xls'
        @sheet_file.open do |file|
          @xlsx = Roo::Excel.new(file)
        end
      else
        @sheet_file.open do |file|
          @xlsx = Roo::Excelx.new(file)
        end
      end
      @sheet = @xlsx.sheet(@xlsx.sheets[0])

      @config = @table_list.config
      @column_index = init_header.compact
    end

    def init_header
      headers = @config.columns.map { |_, v| v[:header] }
      file_header = @sheet.row(1)

      headers.map do |header|
        file_header.find_index(header)
      end
    end

    def results
      results = []
      @sheet.each do |row|
        results << column_index.map { |index| row[index] }
      end
      results
    end

  end
end
