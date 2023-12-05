module Datum
  module Model::DataList
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :comment, :string
      attribute :type, :string
      attribute :columns, :json, default: {}
      attribute :x_position, :integer
      attribute :data_table, :string
      attribute :export_excel, :string
      attribute :export_pdf, :string

      has_many :table_lists, dependent: :destroy
      has_many :table_items, through: :table_lists

      scope :published, -> { where(published: true) }

      before_create :update_parameters, if: -> { type == 'Datum::DataExport' }
    end

    def rebuild!
      update_parameters
      self.save
    end

    def update_parameters
      export.parameters.each do |p|
        self.parameters[p] = nil
      end
      self.x_position = export.columns.index { |i| i[:x_axis] }
    end

    def export
      @export ||= data_table.to_s.safe_constantize
    end

    def config_excel
      @config_excel ||= export_excel.to_s.safe_constantize
    end

    def config_pdf
      @config_pdf ||= export_pdf.to_s.safe_constantize
    end

    class_methods do
      def sync
        RailsExtend::Exports.exports.each do |klass|
          r = Datum::DataExport.find_or_initialize_by(data_table: klass.to_s)
          r.title = klass.name
          r.save
        end
        RailsExtend::Exports.imports.each do |klass|
          r = Datum::DataImport.find_or_initialize_by(data_table: klass.to_s)
          r.title = klass.name
          r.save
        end
      end
    end

  end
end
