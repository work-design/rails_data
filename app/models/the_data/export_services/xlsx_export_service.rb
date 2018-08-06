require 'write_xlsx'
class XlsxExportService
  include DataExportHelper
  attr_reader :sheet, :headers, :table_list,
              :parameters


  def initialize(table_list = nil, data_list, params)
    headers =

    @config_table = data_list.config_table
    @parameters = params


    @io = StringIO.new
    @workbook = WriteXLSX.new(@io)
    @sheet = @workbook.add_worksheet
  end

  def to_xlsx(params)
    sheet.write_row(0, 0, self.headers)

    @config_table.collection.call(params).each_with_index do |object, index|
      row = field_result(object, index)
      sheet.write_row(index + 1, 0, row)
    end

    @workbook.close
    @io.string
  end

  def cached_to_xlsx
    sheet.write_row(0, 0, headers)

    table_list.table_items.each_with_index do |table_item, index|
      sheet.write_row(index + 1, 0, table_item.fields)
    end

    sheet.write_row table_list.table_items_count + 1, 0, table_list.footers

    @workbook.close
    @io.string
  end

  def xlsx_file_name
    "#{self.id}.xlsx"
  end

end