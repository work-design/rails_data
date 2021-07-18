require 'write_xlsx'
module Datum
  class XlsxExporter
    include DataExportHelper # get field_result

    def initialize(export:, params: [])
      @headers = header_result
      @params = params
      @export = export


      # 初始化 xlsx
      @io = StringIO.new
      @workbook = WriteXLSX.new(@io)
      @sheet = @workbook.add_worksheet
    end

    def direct_xlsx
      @sheet.write_row(0, 0, headers)

      @export.collection.call(@params).each_with_index do |object, index|
        row = field_result(object, index)
        @sheet.write_row(index + 1, 0, row)
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

  end
end
