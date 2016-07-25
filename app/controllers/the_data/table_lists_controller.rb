class TheData::TableListsController < TheData::BaseController
  before_filter :set_data_list
  before_filter :set_table_list, only: [:show, :edit, :update, :row]

  def index
    @table_lists = @data_list.table_lists
  end

  def new
    @table_list = @data_list.table_lists.build
  end

  def create
    @table_list = @data_list.table_lists.build(table_list_params)
    @table_list.save

    redirect_to data_list_table_lists_url(@data_list)
  end

  def show
    respond_to do |format|
      format.js
      format.csv { send_data @table_list.csv_string, filename: @table_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @table_list.to_pdf.render, filename: @table_list.pdf_file_name, type: 'application/pdf' }
    end
  end

  def edit
  end

  def update
    @table_list.update(table_list_params)
    redirect_to data_lists_url
  end

  def row
    send_data @table_list.to_row_pdf.render,
              filename: @table_list.pdf_file_name,
              type: 'application/pdf'
  end

  def run
    TableWorker.perform_async(@data_list.id)
  end


  private
  def set_table_list
    @table_list = @data_list.table_lists.find(params[:id])
  end

  def set_data_list
    @data_list = DataList.find params[:data_list_id]
  end

  def table_list_params
    params[:table_list].permit(parameters: [])
  end


end
