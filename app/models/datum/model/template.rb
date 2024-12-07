module Datum
  module Model::Template
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :headers, :json
      attribute :template_items_count, :integer

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :template_examples
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
      set_rows
      set_validation

      workbook.close
      io = workbook.instance_variable_get :@file
      io.string
    end

    def set_headers
      format = workbook.add_format(
        valign: 'vcenter',
        align:  'center'
      )

      worksheet.merge_range('B3:D4', 'Vertical and horizontal', format)
    end

    def set_rows(row_index = 0)
      worksheet.write_row(row_index, 0, headers.keys)
      template_items.each do |item|
        row_index += 1
        r = headers.each_with_object({}) { |(k, _), h| h.merge! k => item.extra[k] }
        worksheet.write_row(row_index, 0, r.values)
      end
    end

    def set_validation
      #validations.each do |v|
        worksheet.data_validation(
          'A:A',
          {
            validate: 'list',
            value: ['open', 'high', 'close']
          }
        )
      #end
    end

    def parse!
      sheet = xlsx.sheet(0)
      sheet_fields = sheet.parse smart: true
      self.headers = sheet.headers
      self.parameters = sheet.headers.each_with_object({}) { |(k, v), h| h.merge! k => 'string' }
      sheet_fields.each_with_index do |fields, index|
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
