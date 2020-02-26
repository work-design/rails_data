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
      params = column[:field].parameters.to_array_h.to_combine_h
      if Array(params[:key]).include? :index
        results << column[:field].call(object, index)
      elsif params[:key]
        results << column[:field].call(object, **@params.slice(params[:key]))
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
