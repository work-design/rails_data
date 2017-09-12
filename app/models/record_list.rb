class RecordList < ApplicationRecord
  include TheRecordExport

  TYPE = {
    date: { input: 'date', output: 'to_date' },
    integer: { input: 'number', output: 'to_i' },
    string: { input: 'text', output: 'to_s' }
  }

  serialize :columns, Hash
  serialize :parameters, Hash
  belongs_to :data_list

  def run
    to_table
  end


end