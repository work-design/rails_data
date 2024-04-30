module Datum
  module Model::DataList::DataExport
    extend ActiveSupport::Concern

    included do
      before_create :update_parameters
    end

    def update_parameters
      export.parameters.each do |p|
        self.parameters[p] = nil
      end
      self.x_position = export.columns.index { |i| i[:x_axis] }
    end

    def just_run
    end

    class_methods do
      def sync
        RailsCom::Exports.exports.each do |klass|
          r = Datum::DataExport.find_or_initialize_by(data_table: klass.to_s)
          r.title = klass.name
          r.save
        end
      end
    end

  end
end
