# frozen_string_literal: true

module Tables::Total
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

  def total_table(data, **options)
    return if data[0].blank?
    width = bounds.width / data[0].size

    default_options = {
      position: :center,
      width: bounds.width,
      column_widths: Array.new(data[0].size, width),
      cell_style: {
        borders: [],
        padding: [5, 10, 5, 0],
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
