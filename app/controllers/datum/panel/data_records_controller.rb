module Datum
  class Panel::DataRecordsController < Panel::BaseController
    before_action :set_data_record, only: [:show, :edit, :update, :rebuild, :destroy]

    def new
      @data_record = DataRecord.new(type: params[:type])
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
      result['parameters'] = result['parameters'].values.each_with_object({}) { |i, h|  h.merge! i['column'] => i['value'] }
      result
    end

  end
end
