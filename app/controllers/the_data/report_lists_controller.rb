class TheData::ReportListsController < TheData::BaseController
  before_filter :set_report_list, only: [:show, :update_publish, :destroy]
  #after_filter :set_reportable, only: [:new, :create, :show]

  def reportable

  end

  def new
    @report_list = ReportList.new(reportable_type: params[:reportable_type],
                                  reportable_id: params[:reportable_id],
                                  reportable_name: params[:reportable_name])
  end

  def create
    @report_list = ReportList.new(params[:report_list])
    @report_list.save

    TableWorker.perform_async(@report_list.id)

    redirect_to report_list_table_lists_url(@report_list.id)
  end

  def update_publish
    @report_list.published = !@report_list.published
    @report_list.save

    redirect_to :back
  end

  def show
    respond_to do |format|
      format.html
      format.pdf { send_data @report_list.pdf_string, filename: @report_list.filename, type: 'application/pdf' }
    end
  end

  def destroy
    @report_list.destroy
    redirect_to report_lists_url, notice: 'Export file was successfully destroyed.'
  end


  private
  def set_report_list
    @report_list = ReportList.find params[:id]
  end

  def set_reportable
    @reportable = params[:reportable_type].safe_constantize.find params[:reportable_id]
  end

end
