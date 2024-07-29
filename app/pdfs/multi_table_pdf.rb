# frozen_string_literal: true

class MultiTablePdf < TablePdf
  attr_accessor :multi_data

  def run
    return self unless self.empty?

    repeat_header header_data if header_data
    multi_data.each_with_index do |value, index|
      move_down 20 unless index == 0
      pdf = value[:pdf].constant.new
      pdf.table_data = value[:table_data]
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

end