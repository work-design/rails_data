# frozen_string_literal: true

module Tables::ImagePage

  def image_page_table(data, **options)
    data.each do |title, images|
      images.each_with_index do |img, index|
        start_new_page
        move_down 20
        text "#{title}, 共#{images.size}张，第#{index + 1}张"
        image img, position: :center, vposition: :center, fit: [bounds.width, bounds.height], **options
      end
    end
  end

end
