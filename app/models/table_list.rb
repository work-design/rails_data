class TableList < ActiveRecord::Base
  belongs_to :report_list, counter_cache: true
  has_many :table_items, dependent: :destroy

  validates :headers, format: { with: /\n\z/, message: "must end with return" }

  def brothers
    self.class.where(report_list_id: self.report_list_id)
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
      CSV.parse_line(headers)
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

  def csv_file_name
    "#{self.id}.csv"
  end

  def pdf_file_name
    "#{self.id}.pdf"
  end

end