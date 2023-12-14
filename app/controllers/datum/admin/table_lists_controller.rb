module Datum
  class Admin::TableListsController < Panel::TableListsController
    include Controller::Admin
    before_action :set_data_list
    before_action :set_table_list

    def find
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(*@data_list.parameters.keys)

      @table_list = @data_list.table_lists.find_or_create_by(parameters: q_params)
      @table_list.cached_run(params[:timestamp])
      @table_items = @table_list.table_items.page(params[:page]).per(100)
    end

    def new_import
      @table_list = @data_list.table_lists.build
    end

    def create_import
      @table_list = @data_list.table_lists.build(file_params)
      @table_list.save
      #@table_list.import_to_table_list

      @table_items = @table_list.table_items.page(params[:page]).per(100)
    end

    private
    def set_data_list
      @data_list = DataList.find_by data_table: params[:data_list_id]
    end

  end
end
