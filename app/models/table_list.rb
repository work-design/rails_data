class TableList < ActiveRecord::Base
  TYPE = {
    date: { input: 'date', output: 'to_date' },
    integer: { input: 'number', output: 'to_i' },
    string: { input: 'text', output: 'to_s' }
  }
  include TheDataExport
  serialize :parameters, Hash

  belongs_to :data_list, counter_cache: true, optional: true
  has_many :table_items, dependent: :delete_all

  validates :headers, format: { with: /\n\z/, message: "must end with return" }, allow_blank: true

  def run
    clear_old
    to_table
  end

  def converted_parameters
    param = {}
    parameters.each do |k, v|
      param.merge! k.to_sym => v.send(TYPE[data_list.parameters[k].to_sym][:output])
    end
    param
  end

  def clear_old
    self.class.transaction do
      self.update!(done: false)
      table_items.delete_all
    end
  end

  def brothers
    self.class.where(data_list_id: self.data_list_id)
  end

  def csv_array
    table = []
    table << csv_headers
    csv_fields.each do |row|
      table << row
    end
    table << csv_footers if csv_footers.present?
    table
  end

  def csv_headers
    begin
      CSV.parse_line(headers || ',')
    rescue
      CSV.parse_line(headers, quote_char: '\'')
    end
  end

  def csv_fields
    csv = []
    self.table_items.each do |item|
      csv << item.csv_fields
    end
    csv
  end

  def csv_footers
    if self.footers.present?
      CSV.parse_line(self.footers)
    else
      []
    end
  end

  def group_by_first_column
    csv_fields.group_by { |i| i[0] }
  end

  def csv_string
    csv = ''
    csv << headers
    self.table_items.each do |table_item|
      csv << table_item.fields
    end
    csv
  end

  def to_xlsx
    io = ReportXlsx.write_csv csv_array
    io.string
  end

  # for import
  def import_to_table_list(file)
    importer = data_list.importer(file)
    self.headers = importer.results[0].to_csv
    self.done = true
    self.save
    importer.results[1..-1].each do |row|
      table_items.create(fields: row.to_csv)
    end
  end

  # for import
  def import_columns
    config = data_list.config_table.config
    columns = {}
    config.columns.each do |key, value|
      columns[key] = config.columns[key].merge(index: self.csv_headers.find_index(value[:header]))
    end
    columns.reject { |_, v| v[:index].nil? }
  end

  def migrate
    config = data_list.config_table.config
    columns = import_columns
    self.csv_fields.each do |row|
      attr = {}
      columns.map do |key, value|
        attr[key] = row[value[:index]]
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

  def xlsx_file_name
    "#{self.id}.xlsx"
  end

end