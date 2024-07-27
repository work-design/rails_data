# frozen_string_literal: true

class MultiPagePdf < TablePdf
  attr_accessor :multi_data

  def run
    return self unless self.empty?

    repeat_header header_data if header_data
    multi_data.each_with_index do |value, index|
      start_new_page unless index == 0
      once_header value[:header]
      content_table value[:table]
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

end