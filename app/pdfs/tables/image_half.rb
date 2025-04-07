# frozen_string_literal: true

module Tables::ImageHalf
  HEAD_TD = {
    borders: [:bottom],
    border_color: 'eeeeee'
  }

  def image_half_table(data, **options)
    return if data.blank?
    _data = []
    width = bounds.width / 2
    data.map do |title, images|
      _data << [title]
      _data << images.map { |i| i.merge! image_width: width, position: :center, vposition: :bottom }
    end

    default_options = {
      position: :right,
      width: width,
      column_widths: [width],
      cell_style: {
        borders: [],
        padding: [5, 0],
        inline_format: true
      }
    }
    default_options.merge! options.slice(*BasePdf::ALLOW_OPTIONS)
    undash
    bounding_box [bounds.left + width, cursor + 320], width: width do
      table(_data, default_options) do
        rows(0).style HEAD_TD
      end
    end
  end

end
