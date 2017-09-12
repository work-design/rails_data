class RecordItem < ApplicationRecord
  serialize :fields, Array
  belongs_to :record_list, counter_cache: true


end