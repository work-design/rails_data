# frozen_string_literal: true

module Tables::Total
  LEFT_TD = {
    size: 12,
    align: :left
  }
  RIGHT_TD = {
    size: 12,
    align: :right
  }
  HEAD_TD = {
    size: 12,
    style: :bold
  }

  def total_table(data, options = {})
    default_options = {
      position: :center,
      width: bounds.width,
      column_widths: {
        0 => bounds.width / 2,
        1 => bounds.width / 2
      },
      cell_style: {
        borders: [],
        padding: [5, 0],
        inline_format: true
      }
    }
    default_options.merge!(options)
    undash
    table(data, default_options) do
      rows(0).style HEAD_TD
      columns(0..-2).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

end
