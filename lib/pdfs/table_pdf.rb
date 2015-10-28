require 'prawn/measurement_extensions'
require 'prawn'
require_relative 'defaults/table_pdf'

# a pdf object should response these methods
# * document
# * repeat_header
# * once_header
# * custom_table
# * once_footer
# * repeat_footer


class TablePdf
  include Prawn::View
  include DefaultTablePdf
  attr_accessor :page, :beginning_data, :header_data, :footer_data, :ending_data, :table_data

  def initialize
    @page = true
    @beginning_data = nil
    @header_data = nil
    @footer_data = nil
    @ending_data = nil
    @table_data = []
  end

  def document
    default_config = {
      page_size: 'A4',
      margin: 75
    }
    @document ||= Prawn::Document.new(default_config)
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

end


class Prawn::Document

  def empty?
    page.content.stream.length <= 2
  end

end
