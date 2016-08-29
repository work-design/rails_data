module TheData::Export

  def to_table
    @table_list = TableList.find(table_list_id)
    @table_list.headers = header_result.to_csv
    @table_list.footers = footer_result.to_csv
    @table_list.save

    to_table_items

    @config_table = data_list.config_table
  end

  def header_result
    results = []

    columns.each do |_, column|
      if column[:header].respond_to?(:call)
        results << column[:header].call
      else
        results << column[:header].titleize
      end
    end
    results
  end

  def to_table_items
    @config_table.collection.call.each_with_index do |object, index|
      row = field_result(object, index)
      table_items.create(fields: row.to_csv)
    end
  end

  def field_result(object, index)
    results = []
    @config_table.columns.each do |_, column|
      if column[:field].arity == 2
        results << column[:field].call(object, index)
      elsif column[:field].arity == 1
        results << column[:field].call(object)
      end
    end

    CSV::Row.new(header_result, results)
  end

  def footer_result
    results = []

    @config_table.columns.each do |_, column|
      if column[:footer].respond_to?(:call)
        results << column[:footer].call
      else
        results << column[:footer]
      end
    end
    results
  end

end
