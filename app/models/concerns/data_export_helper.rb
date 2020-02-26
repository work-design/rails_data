module DataExportHelper
  extend ActiveSupport::Concern
  included do
    attr_reader :params, :config_table
  end

  def convert_parameters(parameters)
    @params = {}
    parameters.each do |k, v|
      @params.merge! k.to_sym => v.send(RailsData.config.mapping[@data_list.parameters[k].to_sym][:output])
    end
    @params
  end

  def header_result
    results = {}

    @config_table.columns.each do |key, column|
      if column[:header].respond_to?(:call)
        results[key] = column[:header].call
      else
        results[key] = column[:header]
      end
    end
    results
  end

  def field_result(object, index)
    results = {}
    @config_table.columns.each do |key, column|
      params = column[:field].parameters.to_array_h.to_combine_h
      if Array(params[:key]).include? :index
        results[key] = column[:field].call(object, index)
      elsif params[:key]
        results[key] = column[:field].call(object, **@params.slice(params[:key]))
      elsif params[:key].blank? && params[:req]
        results[key] = column[:field].call(object)
      else
        results[key] = nil
      end
    end

    results
  end

  def footer_result
    results = {}

    @config_table.columns.each do |key, column|
      if column[:footer].respond_to?(:call)
        results[key] = column[:footer].call
      else
        results[key] = column[:footer]
      end
    end
    results
  end

end
