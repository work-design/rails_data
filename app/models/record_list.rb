class RecordList < ApplicationRecord
  TYPE = {
    date: { input: 'date', output: 'to_date' },
    integer: { input: 'number', output: 'to_i' },
    string: { input: 'text', output: 'to_s' }
  }

  serialize :columns, Hash

  belongs_to :data_list
  has_many :record_items, dependent: :delete_all



end