# frozen_string_literal: true

module Tables::TotalRight
  LEFT_TD = {
    align: :left
  }
  RIGHT_TD = {
    align: :right
  }
  HEAD_TD = {
    style: :bold,
    borders: [:bottom],
    border_color: 'eeeeee'
  }

  def total_right_table(data, **options)
    width = bounds.width / (data[0].size + 4)

    default_options = {
      position: :right,
      column_widths: Array.new(data[0].size, width),
      cell_style: {
        borders: [],
        padding: [5, 0],
        inline_format: true
      }
    }
    default_options.merge! options.slice(*BasePdf::ALLOW_OPTIONS)
    undash
    table(data, default_options) do
      rows(0).style HEAD_TD
      columns(0..-2).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

end
