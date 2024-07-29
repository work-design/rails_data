# frozen_string_literal: true
require 'prawn/table'

class TablePdf < BasePdf
  LEFT_TD = {
    align: :left,
    size: 12
  }
  RIGHT_TD = {
    align: :right,
    size: 12
  }

  def initialize(**options)
    super
  end

  def run
    return self unless self.empty?

    repeat_header header_data if header_data
    once_header table_data[:header]
    move_down 20
    custom_table table_data[:table]
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

  def footer_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: []
      }
    }
    undash
    table(data, options) do
      columns(0..-1).style NORMAL_TD
    end
  end

end
