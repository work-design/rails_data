class RecordList < ApplicationRecord
  TYPE = {
    date: { input: 'date', output: 'to_date' },
    integer: { input: 'number', output: 'to_i' },
    string: { input: 'text', output: 'to_s' }
  }

  serialize :attrs, Hash

  belongs_to :data_list, counter_cache: true, optional: true
  has_many :table_items, dependent: :delete_all



end