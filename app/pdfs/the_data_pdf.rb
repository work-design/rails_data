require 'prawn/measurement_extensions'

# a pdf object should response these methods
# * document
# * repeat_header
# * once_header
# * custom_table
# * once_footer
# * repeat_footer


class TheDataPdf < Prawn::Document
  include DefaultPdfTable
  include DefaultPdfText
  include DefaultPdfPage
  attr_accessor :beginning_data, :header_data, :footer_data, :ending_data, :table_data

  def initialize
    default_config = {
      page_size: 'A4'
    }
    super(default_config)
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
