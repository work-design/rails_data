module Datum
  class Admin::TableListsController < Panel::TableListsController
    include Controller::Admin

    def find
      @table_list = @data_list.table_lists.find_or_create_by(parameters: params.permit(*@data_list.parameters.keys).to_h)
      @table_list.cached_run(params[:timestamp])
      @table_items = @table_list.table_items.page(params[:page]).per(100)
    end
  end
end
