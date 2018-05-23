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
      columns(0).style NORMAL_TH
      columns(1..-1).style NORMAL_TD
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
      row(0).style NORMAL_TH
      row(1..-1).style NORMAL_TD
    end
  end

  def grid_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: []
      }
    }
    undash
    table(data, options) do
      columns(0).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

  def content_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :solid, :solid],
        border_color: '999999'
      }
    }
    undash
    table(data, options) do
      row(0..-1).style NORMAL_TD
    end
  end

end