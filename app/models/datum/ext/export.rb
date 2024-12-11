module Datum
  module Ext::Export
    extend ActiveSupport::Concern

    included do
      belongs_to :template, class_name: 'Datum::Template'
    end

    def workbook
      return @workbook if defined? @workbook
      io = StringIO.new
      @workbook = WriteXLSX.new(io)
    end

    def worksheet
      return @worksheet if defined? @worksheet
      @worksheet = workbook.add_worksheet
    end

    def export
      set_headers
      set_rows
      set_validation
      #worksheet.autofit

      workbook.close
      io = workbook.instance_variable_get :@file
      io.string
    end

    def set_headers
      format = workbook.add_format(
        fg_color: '#cccccc',
        valign: 'vcenter',
        align:  'center'
      )

      items = template.template_items.where(position: 1..template.header_line)
      items.each_with_index do |item, row|
        item.fields.adjoin_repeated.each do |col, value|
          if col.is_a?(Array)
            worksheet.merge_range(row, col[0], row, col[1], value, format)
          else
            worksheet.write(row, col, value, format)
          end
        end
      end

      columns = items.pluck(:fields).transpose
      columns.each_with_index do |column, col|
        column.adjoin_repeated.each do |row, value|
          if row.is_a?(Array)
            worksheet.merge_range(row[0], col, row[1], col, value, format)
          end
        end
      end
    end



    def set_validation
      template.validations.each do |v|
        index = template.headers.index(v.header)
        next unless index
        col_str = ColName.instance.col_str(index)
        worksheet.data_validation(
          "#{col_str}:#{col_str}",
          {
            validate: 'list',
            value: v.fields
          }
        )
      end
    end

  end
end
