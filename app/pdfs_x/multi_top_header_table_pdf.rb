# frozen_string_literal: true

class MultiTopHeaderTablePdf < TopHeaderTablePdf
  attr_accessor :multi_data

  def run
    return self unless self.empty?

    once_title title if title
    move_down 20
    repeat_header header_data if header_data
    multi_data.each_with_index do |value, index|
      start_new_page unless index == 0
      once_header value[:header]
      move_down 20
      custom_table value[:table], value[:table_header]
      move_down 20
      once_header value[:footer]
    end
    once_footer
    repeat_footer footer_data if footer_data
    self
  end

end