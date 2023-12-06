module Datum
  class TableJob < ApplicationJob
    queue_as :default

    def perform(table_list)
      table_list.run

      ActionCable.server.broadcast "", body: '<i class="green checkmark icon"></i>', done_id: table_list.id
    end

  end
end
