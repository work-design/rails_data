module Datum
  class Panel::TableListsController < Panel::BaseController
    before_action :set_data_list
    before_action :set_table_list, only: [
      :show, :chart, :xlsx, :edit, :row, :run, :migrate, :update, :destroy
    ]

    def index
      @table_lists = @data_list.table_lists.page(params[:page])
    end

    def new
      @table_list = @data_list.table_lists.build
    end

    def create
      @table_list = @data_list.table_lists.build(table_list_params)
      @table_list.save

      redirect_to data_list_table_lists_url(@data_list)
    end

    def direct
      @table_list = @data_list.table_lists.build(parameters: params.permit(*@data_list.parameters.keys).to_h)
      respond_to do |format|
        format.xlsx { send_data @table_list.direct_xlsx, filename: @table_list.file_name(formats[0]), type: 'application/xlsx' }
      end
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

    def migrate
      @table_list.migrate
    end

    def show
      @table_items = @table_list.table_items.page(params[:page]).per(100)

      respond_to do |format|
        format.html
        format.json {
          #columns = params[:columns].to_s.split(',').presence || @table_list.headers
          render json: @table_list.export_chart_json(params[:column])
        }
        format.csv { send_data @table_list.export_csv, filename: @table_list.file_name(formats[0]), type: 'application/csv' }
        format.pdf { send_data @table_list.to_pdf.render, filename: @table_list.file_name(formats[0]), type: 'application/pdf' }
        format.xlsx { send_data @table_list.cached_xlsx, filename: @table_list.file_name(formats[0]), type: 'application/xlsx' }
      end
    end

    def chart
      @table_items = @table_list.table_items.page(params[:page]).per(100)
    end

    def update
      @table_list.update(table_list_params)
      redirect_to data_list_table_lists_url(@data_list)
    end

    def row
      send_data @table_list.to_row_pdf.render, filename: @table_list.pdf_file_name, type: 'application/pdf'
    end

    def xlsx
      respond_to do |format|
        format.xlsx { send_data @table_list.direct_xlsx, filename: @table_list.file_name(formats[0]), type: 'application/xlsx' }
      end
    end

    def run
      user_id = defined?(current_user) && current_user&.id
      TableJob.perform_later(@table_list, user_id)
    end

    private
    def set_table_list
      @table_list = @data_list.table_lists.find(params[:id])
    end

    def set_data_list
      if /\d/.match? params[:data_list_id]
        @data_list = DataList.find params[:data_list_id]
      else
        @data_list = DataList.find_by data_table: params[:data_list_id]
      end
    end

    def table_list_params
      params.fetch(:table_list, {}).permit(
        parameters: @data_list.parameters.keys
      )
    end

    def file_params
      params.fetch(:table_list, {}).permit(
        :file
      )
    end

  end
end
