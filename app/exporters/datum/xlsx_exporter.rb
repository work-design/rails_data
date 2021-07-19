require 'write_xlsx'
module Datum
  class XlsxExporter < BaseExporter

    def run
      io = StringIO.new
      workbook = WriteXLSX.new(io)
      sheet = workbook.add_worksheet

      sheet.write_row(0, 0, @headers)

      @export.collection.call(@params).each_with_index do |object, index|
        sheet.write_row index + 1, 0, field_result(object, index)
      end

      workbook.close
      io.string
    end

  end
end
