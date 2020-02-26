require 'rails_com/utils/setting'
module RailsData::DataList
  extend ActiveSupport::Concern
  included do
    attribute :title, :string
    attribute :comment, :string, limit: 4096
    attribute :type, :string
    attribute :parameters, :json, default: {}
    attribute :columns, :json, default: {}
    attribute :x_field, :string
    attribute :data_table, :string
    attribute :export_excel, :string
    attribute :export_pdf, :string

    has_many :table_lists, dependent: :destroy
    has_many :table_items, through: :table_lists

    scope :published, -> { where(published: true) }

    before_create :update_parameters
  end

  def rebuild!
    update_parameters
    self.save
  end

  def form_parameters
    r = parameters.map { |k, v| { key: k, value: v } }
    if r.blank?
      r = [{ key: nil, value: nil }]
    end
    RailsCom::Settings.new(r)
  end

  def update_parameters
    config_table.parameters.each do |p|
      self.parameters[p] = nil
    end
    self.x_field = config_table.x_field
  end

  def config_table
    @config_table ||= data_table.to_s.safe_constantize
  end

  def config_excel
    @config_excel ||= export_excel.to_s.safe_constantize
  end

  def config_pdf
    @config_pdf ||= export_pdf.to_s.safe_constantize
  end

end
