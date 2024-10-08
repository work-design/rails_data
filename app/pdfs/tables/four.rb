# frozen_string_literal: true

module Tables::Four
  NORMAL_TH = {
    size: 14,
    background_color: 'eeeeee',
    valign: :center,
    padding: 0
  }
  NORMAL_TD = {
    valign: :center
  }

  def four_table(data, **options)
    width = (bounds.width - 14 * 16) / 2
    default_options = {
      column_widths: {
        0 => 14 * 8,
        1 => width,
        2 => 14 * 8,
        3 => width
      },
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [:top, :bottom],
        border_width: 0.5,
        border_lines: [:solid, :solid, :solid, :solid]
      }
    }
    default_options.merge! options.slice(*BasePdf::ALLOW_OPTIONS)
    undash
    table(data, default_options) do
      columns(0).style NORMAL_TH
      columns(1).style NORMAL_TD
      columns(2).style NORMAL_TH
      columns(3).style NORMAL_TD
    end
  end

end
