class TheDataAdmin::TableListsController < TheDataAdmin::BaseController
  before_action :set_data_list
  before_action :set_table_list, only: [:show, :xlsx, :edit, :row, :run, :migrate, :update, :destroy]
  skip_before_action :require_role
  before_action do |controller|
    controller.require_role(params[:data_list_id])
  end

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

  def find
    @table_list = @data_list.table_lists.find_or_create_by(parameters: params.permit(*@data_list.parameters.keys).to_h)
    @table_list.cached_run(params[:timestamp])
    @table_items = @table_list.table_items.page(params[:page]).per(100)
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
    @table_list = @data_list.table_lists.build
    @table_list.import_to_table_list(file_params.tempfile)

    @table_items = @table_list.table_items.page(params[:page]).per(100)
  end

  def migrate
    @table_list.migrate
    redirect_back fallback_location: data_list_table_lists_url(@data_list)
  end

  def show
    @table_items = @table_list.table_items.page(params[:page]).per(100)

    respond_to do |format|
      format.html
      format.csv { send_data @table_list.to_csv, filename: @table_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @table_list.to_pdf.render, filename: @table_list.pdf_file_name, type: 'application/pdf' }
      format.xlsx { send_data @table_list.cached_xlsx, filename: @table_list.file_name(self.formats[0]), type: 'application/xlsx' }
    end
  end

  def edit
  end

  def update
    @table_list.update(table_list_params)
    redirect_to data_list_table_lists_url(@data_list)
  end

  def row
    send_data @table_list.to_row_pdf.render,
              filename: @table_list.pdf_file_name,
              type: 'application/pdf'
  end

  def xlsx
    respond_to do |format|
      format.xlsx { send_data @table_list.direct_xlsx, filename: @table_list.file_name(formats[0]), type: 'application/xlsx' }
    end
  end

  def run
    TableJob.perform_later(@table_list.id, current_user&.id)
  end

  def destroy
    @table_list.destroy
    redirect_to data_list_table_lists_url(@data_list), notice: 'Export file was successfully destroyed.'
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
    params.fetch(:table_list, {}).permit(parameters: @data_list.parameters.keys)
  end

  def file_params
    params.fetch(:table_list, {}).fetch(:file)
  end


end
