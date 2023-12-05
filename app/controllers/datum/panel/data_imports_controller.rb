module Datum
  class Panel::DataImportsController < Panel::BaseController
    before_action :set_data_import, only: [:show, :edit, :update, :rebuild, :destroy, :template]

    def index
      q_params = {}

      @data_imports = DataImport.default_where(q_params).page(params[:page])
    end

    def sync
      DataImport.sync
    end

    def rebuild
      @data_import.rebuild!
    end

    def template
      send_data @data_import.template, filename: 'template.xlsx', type: 'application/xlsx'
    end

    private
    def set_data_import
      @data_import = DataImport.find params[:id]
    end

    def data_import_params
      result = params.fetch(:data_import, {}).permit(
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
