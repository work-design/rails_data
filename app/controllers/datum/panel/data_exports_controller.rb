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
      result['parameters'] = result['parameters'].values.each_with_object({}) { |i, h|  h.merge! i['column'] => i['value'] }
      result
    end

  end
end
