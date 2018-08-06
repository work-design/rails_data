class DataCacheService
  include DataExportHelper
  attr_reader :table_list,
              :config_table

  def initialize(table_list)
    @table_list = table_list
    @config_table = table_list.data_list.config_table
  end

  def cache_table
    table_list.headers = header_result
    table_list.cache_table_items
    table_list.footers = footer_result
    table_list.done = true
    table_list.save
  end

  def cache_table_items
    config_table.collection.call(converted_parameters).each_with_index do |object, index|
      row = field_result(object, index)
      table_list.table_items.create(fields: row)
    end
  end

end
