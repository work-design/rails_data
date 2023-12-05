module Datum
  module Service::Import

    def import_to_table_list
      self.file.open do |f|
        importer = Importer.new(data_list.export, f)
        self.headers = importer.results[0]
        self.done = true
        self.save
        importer.results[1..-1].each_slice(500) do |result|
          rows = result.map do |row|
            r = { table_list_id: self.id }
            r.merge!(
              fields: row,
              created_at: Time.current,
              updated_at: Time.current
            )
          end

          TableItem.insert_all(rows)
        end
      end
    end

    def import_columns
      config = data_list.export
      columns = {}
      config.columns.each do |key, value|
        columns[key] = config.columns[key].merge(index: self.headers.find_index(value[:header]))
      end
      columns.reject { |_, v| v[:index].nil? }
    end

    def migrate
      config = data_list.export
      columns = import_columns
      self.table_items.find_each do |table_item|
        attr = {}
        columns.map do |key, value|
          r = table_item.fields[value[:index]]
          if value[:field] && value[:field].respond_to?(:call)
            attr[key] = value[:field].call(r)
          else
            attr[key] = r
          end
        end
        config.record.create attr
      end
    end

  end
end
