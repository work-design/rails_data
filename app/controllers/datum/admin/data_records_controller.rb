class Datum::Admin::DataRecordsController < Datum::Admin::BaseController
  before_action :set_data_record, only: [:show, :edit, :update, :rebuild, :destroy]

  def index
    @data_records = DataRecord.page(params[:page])
  end

  def new
    @data_record = DataRecord.new(type: params[:type])
  end

  def create
    @data_record = DataRecord.new(data_record_params)
    @data_record.save

    redirect_to data_records_url(type: @data_record.type)
  end

  def show
  end

  def edit
  end

  def update
    @data_record.update(data_record_params)
    redirect_to data_records_url(type: @data_record.type)
  end

  def add_item
    @data_record = DataRecord.new
  end

  def remove_item

  end

  def rebuild
    @data_record.columns = @data_record.config_columns
    @data_record.save

    redirect_back fallback_location: data_records_url
  end

  def destroy
    @data_record.destroy
  end

  private
  def set_data_record
    @data_record = DataRecord.find params[:id]
  end

  def data_record_params
    result = params[:data_record].permit(
      :type,
      :title,
      :comment,
      :data_table,
      :export_excel,
      :export_pdf,
      parameters: [:key, :value]
    )
    _params = result['parameters']&.values&.map { |i|  {i['key'] => i['value'] } }
    _params = Array(_params).to_combine_h
    result['parameters'] = _params
    result
  end

end
