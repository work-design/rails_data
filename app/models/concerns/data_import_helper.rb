module DataImportHelper

  def import_to_table_list
    self.file.open do |f|
      importer = DataImportService.new(data_list.config_table, f)
      self.headers = importer.results[0]
      self.done = true
      importer.results[1..-1].each do |row|
        table_items.build(fields: row)
      end
      self.save
    end
  end

  def import_columns
    config = data_list.config_table
    columns = {}
    config.columns.each do |key, value|
      columns[key] = config.columns[key].merge(index: self.headers.find_index(value[:header]))
    end
    columns.reject { |_, v| v[:index].nil? }
  end

  def migrate
    config = data_list.config_table
    columns = import_columns
    self.table_items.each do |table_item|
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
    self.destroy
  end

end
