require 'write_xlsx'
class XlsxExportService
  attr_reader :sheet

  def initialize
    @io = StringIO.new
    @workbook = WriteXLSX.new(@io)
    @sheet = @workbook.add_worksheet
  end


  def xlsx_file_name
    "#{self.id}.xlsx"
  end

  def to_xlsx
    sheet.write_row(0, 0, headers)

    self.table_items.each_with_index do |table_item, index|
      sheet.write_row(index + 1, 0, table_item.fields)
    end

    sheet.write_row self.table_items_count + 1, 0, self.footers

    @workbook.close
    @io.string
  end

end