require 'write_xlsx'
module DataListXlsx


  def to_xlsx(params)
    sheet.write_row(0, 0, self.headers)

    @config_table.collection.call(params).each_with_index do |object, index|
      row = field_result(object, index)
      sheet.write_row(index + 1, 0, row)
    end

    @workbook.close
    @io.string
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


end