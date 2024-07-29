# frozen_string_literal: true

class MultiTablePdf < TablePdf
  attr_accessor :multi_data

  def run
    return self unless self.empty?

    repeat_header header_data if header_data
    multi_data.each do |title, value|
      pdf = value[:pdf].constantize.new
      pdf.table_data = {
        header: title,
        table: value[:table_data]
      }
      pdf.run
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

end