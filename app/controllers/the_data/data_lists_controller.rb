class TheData::DataListsController < TheData::BaseController
  before_action :set_data_list, only: [:show, :edit, :update, :destroy]

  def index
    @data_lists = DataList.all
  end

  def new
    @data_list = DataList.new
  end

  def create
    @data_list = DataList.new(data_list_params)
    @data_list.save

    redirect_to data_lists_url
  end

  def show
  end

  def edit
  end

  def update
    @data_list.update(data_list_params)
    redirect_to data_lists_url
  end

  def destroy
    @data_list.destroy
    redirect_to data_lists_url, notice: 'Export file was successfully destroyed.'
  end

  private
  def set_data_list
    @data_list = DataList.find params[:id]
  end

  def data_list_params
    params[:data_list].permit(:title, :comment, :data_table, parameters: @data_list.parameters.keys)
  end

end
