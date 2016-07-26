class TableList < ActiveRecord::Base
  serialize :parameters, Hash

  belongs_to :data_list, counter_cache: true, optional: true
  has_many :table_items, dependent: :destroy

  validates :headers, format: { with: /\n\z/, message: "must end with return" }, allow_blank: true


  def run(save = true, rerun: true)
    clear_old

    if !self.done || rerun
      reportable.public_send(reportable_name)
      self.update_attributes(done: true, published: true)
      ReportFinishMailer.finish_notify(self.id).deliver if self.notice_email.present?
    end

    if save
      self.pdf_to_file
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

  def csv_file_name
    "#{self.id}.csv"
  end

  def pdf_file_name
    "#{self.id}.pdf"
  end

end