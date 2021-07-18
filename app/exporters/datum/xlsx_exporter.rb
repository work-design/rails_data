require 'write_xlsx'
module Datum
  class XlsxExporter
    include DataExportHelper # get export / field_result
    attr_reader :sheet, :table_list, :params, :headers

    def initialize(table_list: nil, params: [], headers: [], export: nil)
      if table_list
        @table_list = table_list
        @data_list = table_list.data_list
      else
        @headers = headers || table_list.headers
        @params = params || table_list.convert_parameters
        @export = export || @data_list.export
      end

      # 初始化 xlsx
      @io = StringIO.new
      @workbook = WriteXLSX.new(@io)
      @sheet = @workbook.add_worksheet
    end

    def direct_xlsx
      sheet.write_row(0, 0, headers)

      @export.collection.call(@params).each_with_index do |object, index|
        row = field_result(object, index)
        sheet.write_row(index + 1, 0, row)
      end

      @workbook.close
      @io.string
    end

    def compute_table_items
      @export.collection.call(@params).each_with_index do |object, index|
        row = field_result(object, index)
        yield row
      end
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
