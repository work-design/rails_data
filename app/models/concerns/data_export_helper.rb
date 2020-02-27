module DataExportHelper
  extend ActiveSupport::Concern
  included do
    attr_reader :params, :config_table
  end

  def header_result
    results = []

    @config_table.columns.each do |column|
      if column[:header].respond_to?(:call)
        results << column[:header].call
      else
        results << column[:header]
      end
    end
    results
  end

  def field_result(object, *args)
    results = []

    @config_table.columns.each do |column|
      results << column[:field].call(object, *args)
    end

    results
  end

  def footer_result
    results = []

    @config_table.columns.each do |column|
      if column[:footer].respond_to?(:call)
        results << column[:footer].call
      else
        results << column[:footer]
      end
    end
    results
  end

end
