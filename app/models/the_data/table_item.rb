class TableItem < ApplicationRecord
  serialize :fields, Array
  belongs_to :table_list, counter_cache: true


end