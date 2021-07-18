require 'write_xlsx'
module Datum
  class Service::Xlsx
    include DataExportHelper
    attr_reader :sheet, :table_list, :params, :headers, :config_table

    def initialize(table_list:, params: table_list.convert_parameters, headers: table_list.headers, config_table: @data_list.config_table)
      @table_list = table_list
      @data_list = table_list.data_list
      @headers = headers
      @params = params
      @config_table = config_table

      @io = StringIO.new
      @workbook = WriteXLSX.new(@io)
      @sheet = @workbook.add_worksheet
    end

    def direct_xlsx
      sheet.write_row(0, 0, headers)

      config_table.collection.call(params).each_with_index do |object, index|
        row = field_result(object, index)
        sheet.write_row(index + 1, 0, row)
      end

      @workbook.close
      @io.string
    end

    def cached_xlsx
      sheet.write_row(0, 0, table_list.headers)

      table_list.table_items.each_with_index do |table_item, index|
        sheet.write_row(index + 1, 0, table_item.fields)
      end

      sheet.write_row table_list.table_items_count + 1, 0, table_list.footers

      @workbook.close
      @io.string
    end

  end
end
