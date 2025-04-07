# frozen_string_literal: true

module Tables::Media

  def media_table(data, **options)
    return if data.blank?
    image = data[:image]
    content = data[:content] || []

    if image
      image image[:url], **image.except(:url)
    end

    bounding_box [image[:width] + 20, cursor + image[:height] ], width: bounds.width - image[:width], height: image[:height] do
      move_down 25
      content.each do |i|
        text i, inline_format: true
      end
    end
  end

end
