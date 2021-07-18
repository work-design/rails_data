module Datum
  class JsonExporter < BaseExporter

    def run
      arr = []

      @export.collection.call(@params).each_with_index do |object, index|
        arr << field_object(object, index)
      end

      arr.to_json
    end

  end
end
