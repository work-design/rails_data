class DataImport < DataList

  def importer(file)
    @importer ||= TheDataImport.new(config_table, file)
  end


  def config_params
    {}
  end
end