# frozen_string_literal: true

module Tables::Four
  NORMAL_TH = {
    size: 14,
    background_color: 'eeeeee',
    valign: :center,
    padding: 0
  }
  NORMAL_TD = {
    size: 12,
    valign: :center
  }

  def xx
    (bounds.width - 14 * 16) / 2
  end

  def four_table(data)
    options = {
      column_widths: {
        0 => 14 * 8,
        1 => xx,
        2 => 14 * 8,
        3 => xx
      },
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
      columns(1).style NORMAL_TD
      columns(2).style NORMAL_TH
      columns(3).style NORMAL_TD
    end
  end

end