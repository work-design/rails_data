module Datum
  module Model::ExportItem
    extend ActiveSupport::Concern

    included do
      attribute :fields, :json
      attribute :position, :integer

      belongs_to :export

      positioned on: :export

      before_save :set_fields, if: -> { extra_changed? }
    end

    def set_fields
      r = export.template.headers.each_with_object({}) { |k, h| h.merge! k => extra[k] }
      self.fields = r.values
    end

  end
end
