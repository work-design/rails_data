require 'write_xlsx'
module Datum
  class CacheExporter < BaseExporter

    def initialize(table_list)
      @table_list = table_list
      super(export: @table_list.data_list.export, params: @table_list.convert_parameters)
    end

    def run
      @table_list.headers = header_result
      @export.collection.call(@params).each_with_index do |object, index|
        @table_list.table_items.build fields: field_result(object, index)
      end
      @table_list.footers = footer_result
      @table_list.done = true
      @table_list.save
    end

  end
end
