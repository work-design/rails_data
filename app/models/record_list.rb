class RecordList < ApplicationRecord
  include TheRecordExport

  serialize :columns, Hash
  serialize :parameters, Hash
  belongs_to :data_list

  def run
    to_table
  end

end