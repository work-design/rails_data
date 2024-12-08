module Datum
  module Model::TemplateItem
    extend ActiveSupport::Concern

    included do
      attribute :fields, :json
      attribute :position, :integer

      belongs_to :template

      positioned on: :template

      before_save :set_fields, if: -> { extra_changed? }
    end

    def set_fields
      r = template.headers.each_with_object({}) { |k, h| h.merge! k => extra[k] }
      self.fields = r.values
    end

  end
end
