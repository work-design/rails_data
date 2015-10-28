class TableItem < ActiveRecord::Base
  belongs_to :table_list, counter_cache: true

  validates :fields, format: { with: /\n\z/, message: "must end with return" }


  def csv_fields
    begin
      CSV.parse_line(fields)
    rescue
      CSV.parse_line(fields, quote_char: '\'')
    end
  end

  def csv_array
    csv = []
    csv << table_list.csv_headers
    csv << csv_fields
    csv
  end

end