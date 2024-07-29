# frozen_string_literal: true

module Tables::Grid
  LEFT_TD = {
    size: 12,
    align: :left
  }
  RIGHT_TD = {
    size: 12,
    align: :left
  }

  # 针对数据
  def grid_table(data, options = {})
    default_options = {
      position: :center,
      width: bounds.width,
      column_widths: {
        0 => bounds.width / 2,
        1 => bounds.width / 2
      },
      cell_style: {
        borders: [],
        padding: [3, 0],
        inline_format: true
      }
    }
    default_options.merge!(options)
    undash
    table(data, default_options) do
      columns(0).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

end
