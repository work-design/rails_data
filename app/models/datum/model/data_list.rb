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
    end

    def rebuild!
      update_parameters
      self.save
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

  end
end
