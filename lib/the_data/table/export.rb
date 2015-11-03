module TheData::Export

  def to_table
    @table_list = TableList.new(data_list_id: data_list_id)
    @table_list.headers = header_values.to_csv
    @table_list.note_header = @note_header
    @table_list.note_footer = @note_footer
    @table_list.footers = footer_result.to_csv
    @table_list.save

    collection_result.each do |object|
      export_row(object)
    end
  end

  def footer_result
    results = []

    return results if footer_values.compact.blank?
    footer_values.each do |v|
     if v.respond_to?(:call)
       results << v.call
     else
       results << v
     end
    end
    results
  end

  def export_row(object)
    results = []
    columns.each do |column|
      results << execute(object, fields[column], arguments[column])
    end

    row = CSV::Row.new(header_values, results)
    @table_list.table_items.create(fields: row.to_csv)
  end

  def execute(object, method, args)
    if method.is_a?(Symbol)
      result = object.send(method, *args)
    elsif method.is_a?(String)
      result = object.instance_eval(method)
    elsif method.blank?
      result = nil
    else
      raise 'wrong method type'
    end

    result.to_s
  end

end
