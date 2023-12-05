module Datum
  class Admin::TableListsController < Panel::TableListsController
    include Controller::Admin

    def find
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(*@data_list.parameters.keys)

      @table_list = @data_list.table_lists.find_or_create_by(parameters: q_params)
      @table_list.cached_run(params[:timestamp])
      @table_items = @table_list.table_items.page(params[:page]).per(100)
    end

  end
end
