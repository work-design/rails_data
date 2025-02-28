module Datum
  module Ext::Export
    extend ActiveSupport::Concern
    LIST_KEY = '数据源'
    EXAMPLE = '注释'

    included do
      attribute :code, :string
      attribute :formats, :json, default: {}

      belongs_to :template, class_name: 'Datum::Template'

      before_validation :sync_code, if: -> { template_id_changed? }
    end

    def sync_code
      self.code = template&.code
      self.formats = template.parameters
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
      set_validation_names
      set_validation
      set_validation_users
      set_user_validation
      set_relevant_validation
      set_note
      #worksheet.autofit
      workbook.close
      io = workbook.instance_variable_get :@file
      io.string
    end

    def export_required_indexes
      []
    end

    def header_line
      template.header_line
    end
    
    def headers
      template.headers
    end

    def set_headers
      format = workbook.add_format(
        fg_color: '#bbbbbb',
        valign: 'vcenter',
        align:  'center',
        border: 1,
        border_color: '#cccccc'
      )
      required_format = workbook.add_format(
        fg_color: '#bbbbbb',
        valign: 'vcenter',
        align:  'center',
        color: 'red',
        border: 1,
        border_color: '#cccccc'
      )

      _format = format
      items = template.template_items.where(position: 1..header_line)
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

    def write_merge_with_format(row1, col1, row2, col2, value, format)
      if formats[headers[col1]] == 'date'
        new_format = workbook.add_format
        new_format.copy(format)
        new_format.set_num_format('yyyy/mm/dd')

        worksheet.data_validation(row1, col1, row2, col2, {
          validate: 'date',
          criteria: '>=',
          value: '1900-01-01',
          input_message: '输入日期格式，如：2025-01-01',
          error_message: '请输入正确的日期格式，如：2025-01-01'
        })
      else
        new_format = format
      end
      worksheet.merge_range(row1, col1, row2, col2, value, new_format)
    end

    def write_with_format(row, col, value, format)
      if formats[headers[col]] == 'date'
        new_format = workbook.add_format
        new_format.copy(format)
        new_format.set_num_format('yyyy/mm/dd')

        worksheet.data_validation(row, col, {
          validate: 'date',
          criteria: '>=',
          value: '1900-01-01',
          input_message: '输入日期格式，如：2025-01-01',
          error_message: '请输入正确的日期格式，如：2025-01-01'
        })
      else
        new_format = format
      end
      worksheet.write(row, col, value, new_format)
    end

    def set_note
      template.validations.where(sheet: EXAMPLE).each do |note|
        index = headers.index(note.header)
        if index
          col_str = ColName.instance.col_str(index)
          worksheet.write_comment(
            "#{col_str}#{header_line}",
            "#{note.fields.join("\n")}",
            width: 250,
            height: 180
          )
        end
      end
    end

    def set_validation_names
      format = workbook.add_format(
        fg_color: '#cccccc',
        valign: 'vcenter',
        align:  'center'
      )
      sheets = template.validations.where.not(sheet: [LIST_KEY, EXAMPLE]).select(:sheet).distinct.pluck(:sheet)
      sheets.each do |sheet_name|
        sheet = workbook.add_worksheet(sheet_name)
        template.validations.where(sheet: sheet_name).each_with_index do |v, index|
          sheet.write(0, index, v.header, format)
          sheet.write_col(1, index, v.fields)

          col_str = ColName.instance.col_str(index)
          workbook.define_name(v.header, "=#{sheet_name}!$#{col_str}$#{header_line + 1}:$#{col_str}$#{v.fields.size + 1}")
        end
        sheet.hide
      end
    end

    def set_validation
      template.validations.where(sheet: LIST_KEY, header: headers).each do |v|
        index = headers.index(v.header)
        col_str = ColName.instance.col_str(index)
        worksheet.data_validation(
          "#{col_str}#{header_line + 1}:#{col_str}1000",
          {
            validate: 'list',
            value: v.fields
          }
        )
      end
    end

    def set_validation_users(name = '工号')
      sheet = workbook.add_worksheet(name)
      userids, user_names = application.app.users.pluck(:userid, :name).transpose
      sheet.write_col(0, 0, userids)
      sheet.write_col(0, 1, user_names)
      workbook.define_name(name, "=#{name}!$A$1:$A$#{userids.size}")
      sheet.hide
    end

    def set_user_validation
      formats.select { |_, v| v == 'user' }.each do |k, _|
        index = headers.index(k)
        col_str = ColName.instance.col_str(index)
        worksheet.data_validation(
          "#{col_str}#{header_line + 1}:#{col_str}1000",
          {
            validate: 'list',
            value: '=INDIRECT("工号")',
            error_message: '请输入正确的工号'
          }
        )

        name_index = headers.index("#{k.delete_suffix('_工号')}_姓名")
        if name_index
          format = export.workbook.add_format(
            valign: 'vcenter',
            align:  'center',
            border: 1,
            border_color: '#cccccc'
          )
          (header_line .. 500).each do |line|
            worksheet.write_with_format(line, name_index, "=IFERROR(VLOOKUP(#{col_str}#{line}, 工号!A:B, 2, FALSE), '未找到')", format)
          end
        end
      end
    end

    # 级联验证解析
    def set_relevant_validation
      sheets = template.validations.where.not(sheet: [LIST_KEY, EXAMPLE]).select(:sheet).distinct.pluck(:sheet)
      sheets.each do |sheet_name|
        index = headers.index(sheet_name)
        col_str = ColName.instance.col_str(index)
        prev_str = ColName.instance.col_str(index - 1)
        worksheet.data_validation(
          "#{col_str}#{header_line + 1}:#{col_str}1000",
          {
            validate: 'list',
            source: "=INDIRECT(#{prev_str}3)"
          }
        )
      end
    end

  end
end
