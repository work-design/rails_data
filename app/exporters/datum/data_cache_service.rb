class DataCacheService
  include DataExportHelper

  def initialize(table_list)
    @table_list = table_list
    @data_list = @table_list.data_list
    @export = table_list.data_list.export
    @params = @table_list.convert_parameters
  end

  def cache_table
    @table_list.headers = header_result
    cache_table_items
    @table_list.footers = footer_result
    @table_list.done = true
    @table_list.save
  end

  def cache_table_items
    @export.collection.call(@params).each_with_index do |object, index|
      row = field_result(object, index)
      @table_list.table_items.create(fields: row)
    end
  end

end
