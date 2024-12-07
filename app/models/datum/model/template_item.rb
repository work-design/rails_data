module Datum
  module Model::TemplateItem
    extend ActiveSupport::Concern

    included do
      attribute :fields, :json

      belongs_to :template, counter_cache: true
    end

  end
end
