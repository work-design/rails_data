module Datum
  module Model::Template
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :headers, :json
      attribute :header_line, :integer
      attribute :template_items_count, :integer

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :template_examples, dependent: :delete_all
      has_many :template_items
      has_many :validations

      has_one_attached :file
    end

    def xlsx
      return @xlsx if defined? @xlsx
      file.open do |t|
        @xlsx = Roo::Excelx.new(t, expand_merged_ranges: true)
      end
      @xlsx
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
      worksheet.autofit

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

      items = template_examples.where(position: 1..header_line)
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

    def set_rows
      format = workbook.add_format(
        valign: 'vcenter',
        align:  'center'
      )

      columns = template_items.pluck(:fields).transpose
      columns.each_with_index do |column, col|
        column.adjoin_repeated(index: header_line).each do |row, value|
          if row.is_a?(Array)
            worksheet.merge_range(row[0], col, row[1], col, value, format)
          else
            worksheet.write(row, col, value, format)
          end
        end
      end
    end

    def set_validation
      validations.each do |v|
        index = headers.index(v.header)
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

    def parse!
      sheet = xlsx.sheet(0)
      sheet.set_headers smart: true
      self.headers = sheet.headers.keys
      self.header_line = sheet.header_line
      self.parameters = sheet.headers.each_with_object({}) { |(k, _), h| h.merge! k => 'string' }
      sheet.each_with_index do |fields, index|
        template_examples.build(fields: fields, position: index + 1)
      end
      self.save
    end

    def parse_validations!
      sheet = xlsx.sheet(1)
      sheet.to_matrix.column_vectors.each do |vector|
        col = vector.compact

        validations.build(
          header: col[0],
          fields: col[1..-1]
        )
      end
      self.save
    end

  end
end
