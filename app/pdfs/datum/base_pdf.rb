require 'prawn'
require 'prawn/measurement_extensions'

module Datum
  class BasePdf < Prawn::Document

    def initialize
      default_config = {
        page_size: 'A4'
      }
      font_families['Alibaba'] = {
        bold: { file: "#{Rails.root}/public/fonts/Alibaba-PuHuiTi-Bold.ttf" },
        normal: { file: "#{Rails.root}/public/fonts/Alibaba-PuHuiTi-Regular.ttf" }
      }
      super(default_config)
      font('Alibaba')
    end

    def run
      return self unless self.empty?

      once_header beginning_data if beginning_data
      repeat_header header_data if header_data
      table_data.each_with_index do |value, index|
        start_new_page unless index == 0
        custom_table value
      end
      once_footer ending_data if ending_data
      repeat_footer footer_data if footer_data
      self
    end

    # todo hack for a bug, need confirm ?
    def empty?
      page.content.stream.length <= 2
    end

  end
end
