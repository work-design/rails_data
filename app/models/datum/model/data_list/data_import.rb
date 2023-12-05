require 'write_xlsx'
module Datum
  module Model::DataList::DataImport
    extend ActiveSupport::Concern

    def template
      io = StringIO.new
      workbook = WriteXLSX.new(io)

      sheet = workbook.add_worksheet
      sheet.write_row(0, 0, headers)

      workbook.close
      io.string
    end

    def headers
      export.columns.values.map(&->(i){ i[:header] })
    end

  end
end
