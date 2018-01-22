class TheData::RecordListsController < TheData::BaseController
  before_action :set_data_list
  before_action :set_record_list, only: [:show, :edit, :row, :run, :update, :edit_columns, :update_columns, :destroy]
  skip_before_action :require_role
  before_action do |controller|
    controller.require_role(params[:data_list_id])
  end

  def index
    extra_params = params.fetch(:q, {}).permit(@data_list.parameters.keys)
    extra_params.reject! { |_, value| value.blank? }
    if extra_params.present?
      query = { parameters: extra_params.to_unsafe_hash }
    else
      query = {}
    end

    @record_lists = @data_list.record_lists.where(query).page(params[:page])
  end

  def new
    @record_list = @data_list.record_lists.build
  end

  def create
    @record_list = @data_list.record_lists.build(record_list_params)
    @record_list.save

    redirect_to data_list_record_lists_url(@data_list)
  end

  def find
    @record_list = @data_list.record_lists.find_or_create_by(parameters: params.permit(*@data_list.parameters.keys).to_h)
    @record_list.run unless @record_list.done
  end

  def show
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @record_list.to_csv, filename: @record_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @record_list.to_pdf.render, filename: @record_list.pdf_file_name, type: 'application/pdf' }
      format.xlsx { send_data @record_list.to_xlsx, filename: @record_list.xlsx_file_name, type: 'application/xlsx' }
    end
  end

  def edit
  end

  def update
    @record_list.update(record_list_params)
    redirect_to data_list_record_lists_url(@data_list)
  end

  def edit_columns
  end

  def update_columns
    @record_list.update(columns: columns_params)
  end

  def row
    send_data @record_list.to_row_pdf.render,
              filename: @record_list.pdf_file_name,
              type: 'application/pdf'
  end

  def run
    @record_list.run
    redirect_back fallback_location: data_list_record_lists_url(@data_list)
  end

  def destroy
    @record_list.destroy
    redirect_to data_list_record_lists_url(@data_list), notice: 'Export file was successfully destroyed.'
  end

  private
  def set_record_list
    @record_list = @data_list.record_lists.find(params[:id])
  end

  def set_data_list
    if /\d/.match? params[:data_list_id]
      @data_list = DataList.find params[:data_list_id]
    else
      @data_list = DataList.find_by data_table: params[:data_list_id]
    end
  end

  def record_list_params
    params.fetch(:record_list, {}).permit(parameters: @data_list.parameters.keys, columns: @data_list.columns.keys)
  end

  def columns_params
    params.fetch(:columns, {}).permit!.to_h
  end

  def file_params
    params.fetch(:record_list, {}).fetch(:file)
  end


end
