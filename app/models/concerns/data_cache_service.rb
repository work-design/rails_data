class DataCacheService
  include DataExportHelper

  def initialize(table_list)
    @table_list = table_list
    @data_list = @table_list.data_list
    @config_table = table_list.data_list.config_table
    convert_parameters(@table_list.parameters)
  end

  def cache_table
    @table_list.keyed_headers = header_result
    @table_list.headers = header_result.values
    cache_table_items
    @table_list.keyed_footers = footer_result
    @table_list.footers = footer_result.values
    @table_list.done = true
    @table_list.save
  end

  def cache_table_items
    @config_table.collection.call(@params).each_with_index do |object, index|
      row = field_result(object, index)
      @table_list.table_items.create(keyed_fields: row, fields: row.values)
    end
  end

end
