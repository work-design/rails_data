# frozen_string_literal: true

class MultiTablePdf < BasePdf
  include Tables::Content
  include Tables::ContentHalf
  include Tables::Four
  include Tables::Grid
  include Tables::Total
  include Tables::TotalRight
  include Tables::Image
  include Tables::ImageHalf
  include Tables::ImagePage
  include Tables::LeftHeader
  include Tables::TopHeader

  attr_accessor :multi_data

  def run(**options)
    return self unless self.empty?

    repeat_header header_data if header_data.present?
    multi_data.each do |_, value|
      move_down 20
      once_header value[:title] if value[:title].present?
      _options = {}
      _options.merge! first_row: {} if value[:title].blank?
      send("#{value[:pdf]}_table", value[:table_data], **_options)
    end
    repeat_footer ending_data if ending_data
    repeat_footer_image ending_data_image if ending_data_image
    self
  end

end