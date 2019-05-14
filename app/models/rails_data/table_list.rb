module RailsData::TableList
  extend ActiveSupport::Concern
  included do
    include DataImportHelper
    attribute :parameters, :json, default: {}
    attribute :headers, :string, array: true, default: []
    attribute :footers, :string, array: true, default: []
  
    belongs_to :data_list, optional: true
    has_many :table_items, dependent: :delete_all
  end
  
  def run
    clear_old
    export = DataCacheService.new(self)
    export.cache_table
  end

  def direct_xlsx
    _headers = self.headers.presence || self.data_list.headers
    export = RailsData::ExportService::Xlsx.new(data_list: self.data_list, params: self.parameters, headers: _headers)
    export.direct_xlsx
  end

  def cached_xlsx
    export = RailsData::ExportService::Xlsx.new(table_list: self)
    export.cached_xlsx
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
