module Datum
  module Model::Export
    extend ActiveSupport::Concern

    included do
      attribute :name, :string

      has_many :export_items
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

    def set_rows
      format = workbook.add_format(
        valign: 'vcenter',
        align:  'center'
      )

      columns = export_items.pluck(:fields).transpose
      columns.each_with_index do |column, col|
        column.adjoin_repeated(index: template.header_line).each do |row, value|
          if row.is_a?(Array)
            worksheet.merge_range(row[0], col, row[1], col, value, format)
          else
            worksheet.write(row, col, value, format)
          end
        end
      end
    end

  end
end
