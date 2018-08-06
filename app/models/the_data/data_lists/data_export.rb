class DataExport < DataList

  def update_headers
    self.headers = config_table.columns.map { |p| p[1][:header] }.join(',')
  end

  def rebuild!
    self.update_headers
    super
  end

end