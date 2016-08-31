class TableJob < ActiveJob::Base
  queue_as :default

  def perform(table_list_id, user_id)
    @table_list = TableList.find(table_list_id)
    @table_list.run

    ActionCable.server.broadcast "user_#{user_id}", body: '完成', done_id: table_list_id
  end

end
