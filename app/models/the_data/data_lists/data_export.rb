class DataExport < DataList

  def headers
    config_table.columns.map { |p| p[1][:header] }
  end

  def just_run

  end

end