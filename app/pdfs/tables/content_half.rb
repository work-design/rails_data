# frozen_string_literal: true

module Tables::ContentHalf
  HEAD_TD = {
    borders: [:bottom],
    border_color: 'eeeeee'
  }

  def content_half_table(data, **options)
    return if data.blank?
    _data = []
    width = bounds.width / 2 - 20
    data.map do |title, content|
      _data << [title]
      _data << [content]
    end

    default_options = {
      position: :left,
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
    bounding_box [bounds.left, cursor], width: width, height: 300 do
      table(_data, default_options) do
        rows(0).style HEAD_TD
      end
    end
  end

end
