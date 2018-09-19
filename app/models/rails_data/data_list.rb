require 'rails_com/utils/setting'
class DataList < ApplicationRecord
  serialize :parameters, Hash
  serialize :columns, Hash

  has_many :table_lists, dependent: :destroy
  has_many :table_items, through: :table_lists

  scope :published, -> { where(published: true) }

  before_create :update_parameters

  def rebuild!
    self.save
  end

  def form_parameters
    r = parameters.map { |k, v| { key: k, value: v } }
    if r.blank?
      r = [{ key: nil, value: nil }]
    end
    Settings.new(r)
  end

  def update_parameters
    self.parameters = config_params
  end

  def config_params
    hash = {}
    config_table.parameters.map { |p| hash[p] = nil }
    hash
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