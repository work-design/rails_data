class TableList < ApplicationRecord
  include TheDataExport
  include ReportXlsx

  serialize :parameters, Hash
  serialize :headers, Array
  serialize :footers, Array

  belongs_to :data_list, optional: true
  has_many :table_items, dependent: :delete_all

  def run
    clear_old
    to_table
  end

  def converted_parameters
    param = {}
    parameters.each do |k, v|
      param.merge! k.to_sym => v.send(TheData.config.mapping[data_list.parameters[k].to_sym][:output])
    end
    param
  end

  def clear_old
    self.class.transaction do
      self.update!(done: false)
      table_items.delete_all
    end
  end

  def to_csv
    csv = ''
    csv << headers.to_csv
    self.table_items.each do |table_item|
      csv << table_item.fields.to_csv
    end
    csv
  end

  # for import
  def import_to_table_list(file)
    importer = data_list.importer(file)
    self.headers = importer.results[0]
    self.done = true
    self.save
    importer.results[1..-1].each do |row|
      table_items.create(fields: row)
    end
  end

  # for import
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
        attr[key] = table_item.fields[value[:index]]
      end
       config.record.create attr
    end
    self.destroy
  end

  def csv_file_name
    "#{self.id}.csv"
  end

  def pdf_file_name
    "#{self.id}.pdf"
  end

end