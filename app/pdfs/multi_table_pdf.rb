# frozen_string_literal: true

require 'prawn/table'
class MultiTablePdf < BasePdf
  include Tables::Content
  include Tables::Four
  include Tables::Grid
  include Tables::Total
  include Tables::TotalRight
  include Tables::Image
  include Tables::LeftHeader
  include Tables::TopHeader

  attr_accessor :multi_data

  def run
    return self unless self.empty?

    repeat_header header_data if header_data
    multi_data.each do |_, value|
      move_down 20
      once_header value[:title] if value[:title].present?
      send("#{value[:pdf]}_table", value[:table_data])
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

end