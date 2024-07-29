# frozen_string_literal: true

module Tables::Image
  HEAD_TD = {
    borders: [:top],
    border_color: 'eeeeee'
  }

  def image_table(data, options = {})
    images = data.values[0]
    width = bounds.width / images.size

    default_options = {
      position: :center,
      width: bounds.width,
      column_widths: Array.new(images.size, width),
      cell_style: {
        borders: [],
        padding: [5, 0],
        inline_format: true
      }
    }
    default_options.merge!(options)
    undash
    table(data.values, default_options) do
      rows(0).style HEAD_TD
    end
  end

end
