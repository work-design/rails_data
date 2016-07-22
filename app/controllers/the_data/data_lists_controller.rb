class TheData::DataListsController < TheData::BaseController
  before_action :set_data_list, only: [:show, :update_publish, :destroy]

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

  def update_publish
    @data_list.published = !@data_list.published
    @data_list.save

    redirect_to :back
  end

  def show
    respond_to do |format|
      format.html
      format.pdf { send_data @data_list.pdf_string, filename: @data_list.filename, type: 'application/pdf' }
    end
  end

  def run
    TableWorker.perform_async(@data_list.id)
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
    params[:data_list].permit(:title, :comment)
  end

end
