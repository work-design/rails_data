# frozen_string_literal: true

module Tables::LeftHeader
  NORMAL_TH = {
    background_color: 'eeeeee'
  }

  def left_header_table(data)
    options = {
      column_widths: { 0 => 120 },
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [:top, :bottom],
        border_width: 0.5,
        border_lines: [:solid, :solid, :solid, :solid]
      }
    }
    undash
    table(data, options) do
      columns(0).style NORMAL_TH
      columns(1..-1).style NORMAL_TD
    end
  end

end
