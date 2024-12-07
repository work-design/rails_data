module Datum
  module Model::Template
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :headers, :json
      attribute :template_items_count, :integer

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :template_items

      has_one_attached :file
    end

    def xlsx
      return @xlsx if defined? @xlsx
      file.open do |t|
        @xlsx = Roo::Excelx.new(t, expand_merged_ranges: true)
      end
      @xlsx
    end

    def parse!
      sheet = xlsx.sheet(0)
      sheet_fields = sheet.parse smart: true
      self.headers = sheet.headers
      sheet_fields.each_with_index do |fields, index|
        template_items.build(fields: fields, position: index + 1)
      end
      self.save
    end

  end
end
