# frozen_string_literal: true

class TablePdf < BasePdf
  NORMAL_TH = {
    align: :center,
    size: 14,
    font_style: :bold,
    background_color: 'eeeeee'
  }
  NORMAL_TD = {
    align: :center,
    size: 12,
  }
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

    once_header
    repeat_header header_data if header_data
    table_data.each_with_index do |value, index|
      start_new_page unless index == 0
      custom_table value[:table]
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

  # 针对数据数据
  def grid_table(data, options = {})
    default_options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: []
      }
    }
    default_options.merge!(options)
    undash
    table(data, default_options) do
      columns(0).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

  # 针对文字内容
  def content_table(data, options = {}, &block)
    return if data.blank?
    default_options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :solid, :solid],
        border_color: '999999'
      }
    }
    default_options.merge!(options)
    undash
    if block_given?
      table(data, default_options, &block)
    else
      table(data, default_options) do
        row(0..-1).style NORMAL_TD
      end
    end
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
