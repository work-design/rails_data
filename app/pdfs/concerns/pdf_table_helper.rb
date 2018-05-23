module PdfTableHelper

  def left_header_table(data)
    th_style = {
      align: :center,
      valign: :center,
      size: 12,
      font_style: :bold,
      height: 30,
      background_color: 'eeeeee',
    }
    td_style = {
      align: :left,
      valign: :center,
      size: 8
    }
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :dashed, :solid]
      }
    }

    table(data, options) do
      columns(0).style th_style
      columns(1..-1).style td_style
    end
  end

  def top_header_table(data)
    th_style = {
      align: :center,
      valign: :center,
      size: 12,
      font_style: :bold,
      height: 30,
      background_color: 'eeeeee',
    }
    td_style = {
      align: :left,
      valign: :center,
      size: 8
    }
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :dashed, :solid]
      }
    }

    table(data, options) do
      row(0).style th_style
      row(1..-1).style td_style
    end
  end

  def grid_table(data)
    left_style = {
      align: :left,
      valign: :center,
      size: 8
    }
    right_style = {
      align: :right,
      valign: :center,
      size: 8
    }
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [],
        border_width: 0
      }
    }

    table(data, options) do
      columns(0).style left_style
      columns(-1).style right_style
    end
  end

  def content_table(data)

    table(data, options) do
      row(0..-1).style td_style
    end
  end

end