class TableJob < ActiveJob::Base
  queue_as :default

  def perform(table_list_id)
    @table_list = TableList.find(table_list_id)
    @table_list.run
  end

end
