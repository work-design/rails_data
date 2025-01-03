module Datum
  module Ext::Export
    extend ActiveSupport::Concern
    LIST_KEY = '数据源'

    included do
      attribute :code, :string

      belongs_to :template, class_name: 'Datum::Template'

      before_validation :sync_code, if: -> { template_id_changed? }
    end

    def sync_code
      self.code = template&.code
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
      set_validation_sheet
      set_validation
      set_relevant_validation
      #worksheet.autofit

      workbook.close
      io = workbook.instance_variable_get :@file
      io.string
    end

    def export_required_indexes
      []
    end

    def set_headers
      format = workbook.add_format(
        fg_color: '#bbbbbb',
        valign: 'vcenter',
        align:  'center'
      )
      required_format = workbook.add_format(
        fg_color: '#bbbbbb',
        valign: 'vcenter',
        align:  'center',
        color: 'red'
      )

      _format = format
      items = template.template_items.where(position: 1..template.header_line)
      items.each_with_index do |item, row|
        item.fields.adjoin_repeated.each do |col, value|
          if col.is_a?(Array)
            worksheet.merge_range(row, col[0], row, col[1], value, _format)
          else
            if export_required_indexes.include?(col)
              _format = required_format
            else
              _format = format
            end
            worksheet.write(row, col, value, _format)
          end
        end
      end

      columns = items.pluck(:fields).transpose
      columns.each_with_index do |column, col|
        if export_required_indexes.include?(col)
          _format = required_format
        else
          _format = format
        end
        column.adjoin_repeated.each do |row, value|
          if row.is_a?(Array)
            worksheet.merge_range(row[0], col, row[1], col, value, _format)
          end
        end
      end
    end

    def set_validation_sheet
      format = workbook.add_format(
        fg_color: '#cccccc',
        valign: 'vcenter',
        align:  'center'
      )
      sheets = template.validations.where.not(sheet: LIST_KEY).select(:sheet).distinct.pluck(:sheet)
      sheets.each do |sheet_name|
        sheet = workbook.add_worksheet(sheet_name)
        template.validations.where(sheet: sheet_name).each_with_index do |v, index|
          sheet.write(0, index, v.header, format)
          sheet.write_col(1, index, v.fields)

          col_str = ColName.instance.col_str(index)
          workbook.define_name(v.header, "=#{sheet_name}!$#{col_str}$2:$#{col_str}$#{v.fields.size + 1}")
        end
      end
    end

    def set_validation
      template.validations.where(sheet: LIST_KEY, header: template.headers).each do |v|
        index = template.headers.index(v.header)
        col_str = ColName.instance.col_str(index)
        worksheet.data_validation(
          "#{col_str}3:#{col_str}20",
          {
            validate: 'list',
            value: v.fields
          }
        )
      end
    end

    #
    def set_relevant_validation
      sheets = template.validations.where.not(sheet: LIST_KEY).select(:sheet).distinct.pluck(:sheet)
      sheets.each do |sheet_name|
        index = template.headers.index(sheet_name)
        col_str = ColName.instance.col_str(index)
        prev_str = ColName.instance.col_str(index - 1)
        worksheet.data_validation(
          "#{col_str}3:#{col_str}20",
          {
            validate: 'list',
            source: "=INDIRECT(#{prev_str}3)"
          }
        )
      end
    end

  end
end
