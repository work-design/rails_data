module Datum
  module Model::Template
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :headers, :json

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_one_attached :file
    end

    def xlsx
      return @xlsx if defined? @xlsx
      file.open do |t|
        @xlsx = Roo::Excelx.new(t, expand_merged_ranges: true)
      end
      @xlsx
    end

  end
end
