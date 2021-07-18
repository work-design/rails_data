module Datum
  module Model::DataList::DataExport

    def headers
      export.columns.map { |p| p[1][:header] }
    end

    def just_run

    end

  end
end
