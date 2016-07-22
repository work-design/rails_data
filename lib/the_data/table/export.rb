module TheData::Export

  def to_table
    @table_list = TableList.new(data_list_id: data_list_id)
    @table_list.headers = header_result
    @table_list.note_header = @note_header
    @table_list.note_footer = @note_footer
    @table_list.footers = footer_result
    @table_list.save

    collection_result.each_with_index do |object, index|
      field_result(object, index)
    end
  end

  def header_result
    results = []

    columns.each do |column|
      if column[:header].respond_to?(:call)
        results << column[:header].call
      else
        results << column[:header].titleize
      end
    end
    results.to_csv
  end

  def footer_result
    results = []

    columns.each do |column|
     if column[:footer].respond_to?(:call)
       results << column[:footer].call
     else
       results << column[:footer]
     end
    end
    results.to_csv
  end

  def field_result(object, index)
    results = []
    columns.each do |column|
      if column[:field].arity == 2
        results << column[:field].call(object, index)
      elsif column[:field].arity == 1
        results << column[:field].call(object)
      end
    end

    row = CSV::Row.new(header_values, results)
    @table_list.table_items.create(fields: row.to_csv)
  end

end
