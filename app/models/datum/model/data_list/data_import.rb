module Datum
  module Model::DataList::DataImport

    def importer(file)
      @importer ||= DataImportService.new(config_table, file)
    end

  end
end
