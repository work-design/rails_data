class TableList < ApplicationRecord
  include DataImportHelper
  serialize :parameters, Hash
  serialize :headers, Array
  serialize :footers, Array

  belongs_to :data_list, optional: true
  has_many :table_items, dependent: :delete_all

  def run
    clear_old
    export = DataExportService.new(self)
    export.cache_table
  end

  def direct_xlsx
    _headers = self.headers || self.data_list.headers
    export = XlsxExportService.new(data_list: self.data_list, params: self.parameters, headers: _headers)
    export.direct_xlsx
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

  def file_name(format)
    name = self.id || 'example'
    "#{name}.#{format}"
  end

end