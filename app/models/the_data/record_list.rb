class RecordList < ApplicationRecord
  include TheRecordExport

  serialize :columns, Hash
  serialize :parameters, Hash
  belongs_to :data_list

  default_scope -> { order(id: :desc) }

  def run
    to_table
  end

end