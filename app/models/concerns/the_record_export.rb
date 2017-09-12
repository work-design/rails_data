module TheRecordExport

  def to_table
    initialize_table
    self.to_table_items
    self.save
  end

  def initialize_table
    @config_table = data_list.config_table
    @config_table.config(converted_parameters)
    @record = @config_table.record
    @config_table
  end

  def converted_parameters
    param = {}
    parameters.each do |k, v|
      param.merge! k.to_sym => v.send(DynamicForm::TYPE[data_list.parameters[k].to_sym][:output])
    end
    param
  end

  def to_table_items
    self.columns = field_result(@record)
  end

  def field_result(object)
    results = {}
    @config_table.columns.each do |key, column|
      if column[:field].arity == 1
        results[key] = column[:field].call(object)
      else
        results[key] = nil
      end
    end

    results
  end

end
