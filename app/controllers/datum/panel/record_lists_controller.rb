class Datum::Panel::RecordListsController < Datum::Panel::BaseController
  before_action :set_data_record
  before_action :set_record_list, only: [:show, :edit, :row, :run, :update, :edit_columns, :update_columns, :destroy]

  def index
    extra_params = params.fetch(:q, {}).permit(@data_record.parameters.keys)
    extra_params.reject! { |_, value| value.blank? }
    if extra_params.present?
      query = { parameters: extra_params.to_unsafe_hash }
    else
      query = {}
    end

    @record_lists = @data_record.record_lists.where(query).page(params[:page])
  end

  def new
    @record_list = @data_record.record_lists.build
  end

  def create
    @record_list = @data_record.record_lists.build(record_list_params)
    @record_list.save

    redirect_to data_record_record_lists_url(@data_record)
  end

  def find
    @record_list = @data_record.record_lists.find_or_create_by(parameters: params.permit(*@data_record.parameters.keys).to_h)
    @record_list.run unless @record_list.done
  end

  def show
    disposition = params[:disposition] || 'inline'
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @record_list.to_csv, filename: @record_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @record_list.to_pdf, filename: @record_list.pdf_file_name, disposition: disposition, type: 'application/pdf' }
      format.xlsx { send_data @record_list.to_xlsx, filename: @record_list.file_name(self.formats[0]), type: 'application/xlsx' }
    end
  end

  def edit
  end

  def update
    @record_list.update(record_list_params)
    redirect_to data_record_record_lists_url(@data_record)
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
    redirect_back fallback_location: data_record_record_lists_url(@data_record)
  end

  def destroy
    @record_list.destroy
    redirect_to data_record_record_lists_url(@data_record), notice: 'Export file was successfully destroyed.'
  end

  private
  def set_record_list
    @record_list = @data_record.record_lists.find(params[:id])
  end

  def set_data_record
    if /\d/.match? params[:data_record_id]
      @data_record = DataRecord.find params[:data_record_id]
    else
      @data_record = DataRecord.find_by data_table: params[:data_record_id]
    end
  end

  def record_list_params
    params.fetch(:record_list, {}).permit(parameters: @data_record.parameters.keys, columns: @data_record.columns.keys)
  end

  def columns_params
    params.fetch(:columns, {}).permit!.to_h
  end

  def file_params
    params.fetch(:record_list, {}).fetch(:file)
  end


end
