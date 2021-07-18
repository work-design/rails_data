require 'write_xlsx'
module Datum
  class XlsxExporter < BaseExporter

    def direct_xlsx
      io = StringIO.new
      workbook = WriteXLSX.new(io)
      sheet = workbook.add_worksheet

      sheet.write_row(0, 0, headers)

      @export.collection.call(@params).each_with_index do |object, index|
        row = field_result(object, index)
        sheet.write_row(index + 1, 0, row)
      end

      workbook.close
      io.string
    end

  end
end
