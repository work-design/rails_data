module RailsData::TableItem
  extend ActiveSupport::Concern
  included do
    attribute :keyed_fields, :json, default: {}
    attribute :fields, :string, array: true, default: []

    belongs_to :table_list, counter_cache: true
  end

end
