module Datum
  class BaseExporter

    def initialize(export:, params: [])
      @headers = header_result
      @params = params
      @export = export
    end

    def header_result
      results = []

      @export.columns.each do |column|
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

      @export.columns.each do |column|
        if column[:field].arity == 1
          results << column[:field].call(object)
        else
          results << column[:field].call(object, *args)
        end
      end

      results
    end

    def field_object(object, *args)
      results = {}

      @export.columns.each do |column|
        if column[:field].arity == 1
          results.merge! column[:key] => column[:field].call(object)
        else
          results.merge! column[:key] => column[:field].call(object, *args)
        end
      end

      results
    end

    def footer_result
      results = []

      @export.columns.each do |column|
        if column[:footer].respond_to?(:call)
          results << column[:footer].call
        else
          results << column[:footer]
        end
      end
      results
    end

  end
end
