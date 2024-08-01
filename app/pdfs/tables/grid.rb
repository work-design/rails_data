# frozen_string_literal: true

module Tables::Grid
  LEFT_TD = {
    align: :left
  }
  RIGHT_TD = {
    align: :left
  }

  def grid_table(data, first_row: { borders: [:top], border_color: 'dddddd' }, **options)
    default_options = {
      position: :center,
      width: bounds.width,
      column_widths: {
        0 => bounds.width / 2,
        1 => bounds.width / 2
      },
      cell_style: {
        borders: [],
        padding: [5, 10, 5, 0],
        inline_format: true
      }
    }
    default_options.merge!(options)
    undash
    table(data, default_options) do
      rows(0).style first_row
      columns(0).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

end
