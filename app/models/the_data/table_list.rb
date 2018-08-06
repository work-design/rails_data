class TableList < ApplicationRecord
  include DataImportHelper
  serialize :parameters, Hash
  serialize :headers, Array
  serialize :footers, Array

  belongs_to :data_list, optional: true
  has_many :table_items, dependent: :delete_all

  def run
    clear_old
    export = DataExportService.new(self.id)
    export.cache_table
  end

  def cached_run(_timestamp = nil)
    unless self.timestamp.present? && self.timestamp == _timestamp.to_s
      self.timestamp = _timestamp
      run
    end
  end

  def clear_old
    self.done = false
    self.class.transaction do
      self.save!
      table_items.delete_all
    end
  end

end