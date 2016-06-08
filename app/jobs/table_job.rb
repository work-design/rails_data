class TableJob


  def perform(report_list_id)
    @report_list = ReportList.find(report_list_id)
    @report_list.run
  end

end
