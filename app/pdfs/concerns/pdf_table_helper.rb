module PdfTableHelper
  NORMAL_TH = {
    align: :center,
    valign: :center,
    size: 12,
    font_style: :bold,
    height: 30,
    background_color: 'eeeeee'
  }
  NORMAL_TD = {
    align: :left,
    valign: :center,
    size: 8
  }
  LEFT_TD = {
    align: :left,
    valign: :center,
    size: 8
  }
  RIGHT_TD = {
    align: :right,
    valign: :center,
    size: 8
  }

  def left_header_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :dashed, :solid]
      }
    }
    undash
    table(data, options) do
      columns(0).style th_style
      columns(1..-1).style td_style
    end
  end

  def top_header_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :dashed, :solid]
      }
    }
    undash
    table(data, options) do
      row(0).style th_style
      row(1..-1).style td_style
    end
  end

  def grid_table(data)

    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [],
        border_width: 0
      }
    }
    undash
    table(data, options) do
      columns(0).style left_style
      columns(-1).style right_style
    end
  end

  def content_table(data)
    undash
    table(data, options) do
      row(0..-1).style td_style
    end
  end

end