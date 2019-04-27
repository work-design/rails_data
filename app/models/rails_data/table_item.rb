module RailsData::TableItem
  extend ActiveSupport::Concern
  included do
    serialize :fields, Array
    belongs_to :table_list, counter_cache: true
  end
  
end
