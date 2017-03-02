require 'write_xlsx'

module ReportXlsx
  extend self

  def write_csv(csv_array)
    sheet.write_col('A1', csv_array)
    @workbook.close
    @io
  end

  def sheet
    @io = StringIO.new
    @workbook = WriteXLSX.new(@io)
    @worksheet = @workbook.add_worksheet

    @format = @workbook.add_format
    @format.set_bold
    @format.set_color('red')
    @format.set_align('center')

    @worksheet
  end


end