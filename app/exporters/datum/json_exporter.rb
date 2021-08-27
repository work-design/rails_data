module Datum
  class JsonExporter < BaseExporter

    def run
      arr = []

      arr << header_result
      @export.collection.call(@params).each_with_index do |object, index|
        arr << field_object(object, index)
      end
      arr << footer_result

      arr.to_json
    end

  end
end
