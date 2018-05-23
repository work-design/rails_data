module PdfPageHelper

  def repeat_header(data = nil)
    repeat :all do
      canvas do
        bounding_box [bounds.left+75, bounds.top-20], :width  => bounds.width do
          process_header(data)
        end
      end
    end
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

  def footer(data = nil, options = {})
    text data
    if options[:page]
      number_pages "<page> / <total>", at: [bounds.right - 50, 0]
    end
  end

end