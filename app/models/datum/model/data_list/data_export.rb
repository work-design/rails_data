module Datum
  module Model::DataList::DataExport
    extend ActiveSupport::Concern

    def just_run
    end

    class_methods do
      def sync
        RailsExtend::Exports.exports.each do |klass|
          r = Datum::DataExport.find_or_initialize_by(data_table: klass.to_s)
          r.title = klass.name
          r.save
        end
      end
    end

  end
end
