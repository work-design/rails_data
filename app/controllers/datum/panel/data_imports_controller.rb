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
      result['parameters'] = result['parameters'].values.each_with_object({}) { |i, h|  h.merge! i['column'] => i['value'] }
      result
    end

  end
end
