# frozen_string_literal: true

module Tables::ImageHalf
  HEAD_TD = {
    borders: [:top],
    border_color: 'eeeeee'
  }

  def image_half_table(data, **options)
    images = data.values[0]
    return if images.blank?
    if images.size <= 2
      size = 2
    elsif images.size >= 4
      size = 4
    else
      size = images.size
    end
    width = bounds.width / size
    if size > images.size
      _data = [(images.map { |i| i.merge! image_width: width, position: :center, vposition: :bottom }).concat(Array.new(size - images.size, nil))]
    else
      _data = [images.map { |i| i.merge! image_width: width, position: :center, vposition: :bottom }]
    end

    default_options = {
      position: :center,
      width: bounds.width,
      column_widths: Array.new(size, width),
      cell_style: {
        borders: [],
        padding: [5, 0],
        inline_format: true
      }
    }
    default_options.merge! options.slice(*BasePdf::ALLOW_OPTIONS)
    undash
    table(_data, default_options) do
      rows(0).style HEAD_TD
    end
  end

end
