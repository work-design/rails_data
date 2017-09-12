class DataImport < DataList

  def importer(file)
    @importer ||= TheDataImport.new(config_table.config, file)
  end


end