module Datum
  class TableJob < ApplicationJob
    queue_as :default

    def perform(table_list, identifier)
      table_list.run(identifier)
    end

  end
end
