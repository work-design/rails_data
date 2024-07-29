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
      cell_style: {
        borders: [],
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
