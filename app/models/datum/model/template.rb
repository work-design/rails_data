module Datum
  module Model::Template
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :code, :string
      attribute :headers, :json
      attribute :header_line, :integer
      attribute :template_items_count, :integer
      attribute :uploaded_at, :datetime

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :template_items, dependent: :delete_all
      has_many :validations
      has_many :exports

      has_one_attached :file

      after_save_commit :parse_all!, if: -> { saved_change_to_uploaded_at? }
    end

    def xlsx
      return @xlsx if defined? @xlsx
      file.open do |t|
        @xlsx = Roo::Excelx.new(t, expand_merged_ranges: true)
      end
      @xlsx
    end

    def root_headers
      x = template_items.load.find { |i| i.position == 1 }.fields
      x.adjoin_repeated
    end

    def parse_all!
      parse!
      parse_validations!
    end

    def parse!
      template_items.delete_all

      sheet = xlsx.sheet(0)
      sheet.set_headers smart: true
      self.headers = sheet.headers.keys
      self.header_line = sheet.header_line
      self.parameters = sheet.headers.each_with_object({}) { |(k, _), h| h.merge! k => 'string' }
      sheet.each_with_index do |fields, index|
        item = template_items.build(position: index + 1)
        item.fields = fields
        item.save
      end
      self.save
    end

    def parse_validations!
      validations.delete_all

      xlsx.sheets[1..-1].each do |sheet|
        xlsx.sheet(sheet).to_matrix.column_vectors.each do |vector|
          col = vector.compact

          validations.create(
            sheet: sheet,
            header: col[0],
            fields: col[1..-1]
          )
        end
      end
    end

  end
end
