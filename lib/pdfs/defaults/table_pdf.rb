module DefaultTablePdf

  def once_header(data = nil)
    text data
  end

  def repeat_header(data = nil)
    repeat :all do
      canvas do
        bounding_box [bounds.left+75, bounds.top-20], :width  => bounds.width do
          process_header(data)
        end
      end
    end
  end

  def once_footer(data = nil)
    move_down 10
    text data
  end

  def repeat_footer(data = nil)
    text data
    number_pages "<page> / <total>", at: [bounds.right - 50, 0] if page
  end

  def process_header(data)
    default_options = {
      cell_style: { borders: [] },
      column_widths: [225, 220]
    }

    table(data, default_options) do
      row(0).style font_style: :bold, size: 14
      row(1..-1).style size: 10
      column(0).style align: :left, padding: 0
      column(1).style align: :right, padding: 0
      cells[2, 0].style size: 12 if cells[2, 0].present?
    end

    move_down 50
  end

  def custom_table(data)
    th_style = {
      align: :center,
      valign: :center,
      size: 12,
      font_style: :bold,
      height: 30,
      background_color: 'eeeeee'
    }
    td_style = {
      align: :left,
      valign: :center,
      size: 8
    }
    options = {
      position: :center,
      width: bounds.width
    }

    table(data, options) do
      row(0).style th_style
      row(1..-1).style td_style
    end
  end

end