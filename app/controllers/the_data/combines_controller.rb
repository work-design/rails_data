class TheData::CombinesController < TheData::BaseController
  before_action :set_combine, only: [:show, :table_lists, :destroy]

  def show

    respond_to do |format|
      format.html
      format.pdf { send_data @combine.pdf_string, filename: @combine.filename, type: 'application/pdf' }
    end
  end

  def table_lists
    @table_lists = @combine.table_lists
  end

  def destroy
    @combine.destroy
    redirect_to combines_url, notice: 'Export file was successfully destroyed.'
  end

  private
  def set_combine
    @combine = Combine.find params[:id]
  end

end
