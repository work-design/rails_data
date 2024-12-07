module Datum
  module Model::TemplateItem
    extend ActiveSupport::Concern

    included do
      attribute :fields, :json
      attribute :position, :integer

      belongs_to :template, counter_cache: true
    end

  end
end
