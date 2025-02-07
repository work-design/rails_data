module Datum
  module Model::TableItem
    extend ActiveSupport::Concern

    included do
      attribute :fields, :json, default: []

      belongs_to :table_list, counter_cache: true
    end

  end
end
