module Datum
  class Panel::DataListsController < Panel::BaseController
    before_action :set_data_list, only: [:show, :edit, :update, :rebuild, :destroy]

    def index
      q_params = {
        type: 'DataExport'
      }
      q_params.merge! params.permit(:type)

      @data_lists = DataList.default_where(q_params).page(params[:page])
    end

    def new
      @data_list = DataList.new(type: params[:type])
      render :new, locals: { model: @data_list }
    end

    def rebuild
      @data_list.rebuild!

      redirect_back fallback_location: data_lists_url
    end

    def just_run
    end

    private
    def set_data_list
      @data_list = DataList.find params[:id]
    end

    def data_list_params
      result = params.fetch(:data_list, {}).permit(
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
