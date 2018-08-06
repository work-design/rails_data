module DataExportHelper

  def converted_parameters
    param = {}
    parameters.each do |k, v|
      param.merge! k.to_sym => v.send(TheData.config.mapping[data_list.parameters[k].to_sym][:output])
    end
    param
  end

  def cache_table_summary
    table_list.headers = header_result
    table_list.cache_table_items
    table_list.footers = footer_result
    table_list.done = true
    table_list.save
  end

  def cache_table_items
    @config_table.collection.call(converted_parameters).each_with_index do |object, index|
      row = field_result(object, index)
      table_list.table_items.create(fields: row)
    end
  end

  def header_result
    results = []

    @config_table.columns.each do |_, column|
      if column[:header].respond_to?(:call)
        results << column[:header].call
      else
        results << column[:header]
      end
    end
    results
  end

  def field_result(object, index)
    results = []
    @config_table.columns.each do |_, column|
      params = column[:field].parameters.to_combined_h
      if Array(params[:key]).include? :index
        results << column[:field].call(object, index)
      elsif params[:key]
        results << column[:field].call(object, **converted_parameters.slice(params[:key]))
      elsif params[:key].blank? && params[:req]
        results << column[:field].call(object)
      else
        results << nil
      end
    end

    results
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
