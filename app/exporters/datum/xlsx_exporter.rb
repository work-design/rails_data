require 'write_xlsx'
module Datum
  class XlsxExporter < BaseExporter

    def run
      io = StringIO.new
      workbook = WriteXLSX.new(io)
      sheet = workbook.add_worksheet
      row_index = 0

      sheet.write_row(row_index, 0, header_result)
      @export.collection.call(@params).each_with_index do |object, index|
        row_index += 1
        sheet.write_row row_index, 0, field_result(object, index)
      end
      sheet.write_row row_index + 1, 0, footer_result

      workbook.close
      io.string
    end

  end
end
