module Datum
  class Panel::DataExportsController < Panel::BaseController
    before_action :set_data_export, only: [:show, :edit, :update, :rebuild, :destroy]

    def index
      q_params = {}

      @data_exports = DataExport.default_where(q_params).page(params[:page])
    end

    def sync
      DataExport.sync
    end

    def rebuild
      @data_export.rebuild!

      redirect_back fallback_location: data_exports_url
    end

    def just_run
    end

    private
    def set_data_export
      @data_export = DataExport.find params[:id]
    end

    def data_export_params
      result = params.fetch(:data_export, {}).permit(
        :type,
        :title,
        :comment,
        :data_table,
        :export_excel,
        :export_pdf,
        parameters: [:column, :value]  #todo key is original method of hash
      )
      _params = result['parameters']&.values&.map { |i|  {i['column'] => i['value'] } }
      _params = Array(_params).to_combine_h
      result['parameters'] = _params
      result
    end

  end
end
