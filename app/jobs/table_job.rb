class TableJob < ApplicationJob
  queue_as :default

  def perform(table_list_id, user_id)
    @table_list = TableList.find(table_list_id)
    @table_list.run

    ActionCable.server.broadcast "user:#{user_id}", body: '<i class="green checkmark icon"></i>', done_id: table_list_id
  end

end
