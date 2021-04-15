module Datum
  class Panel::DataListsController < Panel::BaseController
    before_action :set_data_list, only: [:show, :edit, :update, :rebuild, :destroy]

    def index
      q_params = {
        type: 'DataExport'
      }
      q_params.merge! params.permit(:type)

      @data_lists = DataList.default_where(q_params)
    end

    def new
      @data_list = DataList.new(type: params[:type])
    end

    def create
      @data_list = DataList.new(data_list_params)

      unless @data_list.save
        render :new, locals: { model: @data_list }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @data_list.assign_attributes(data_list_params)

      unless @data_list.save
        render :new, locals: { model: @data_list }, status: :unprocessable_entity
      end
    end

    def rebuild
      @data_list.rebuild!

      redirect_back fallback_location: data_lists_url
    end

    def just_run
    end

    def destroy
      @data_list.destroy
    end

    private
    def set_data_list
      @data_list = DataList.find params[:id]
    end

    def data_list_params
      result = params[:data_list].permit(
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
