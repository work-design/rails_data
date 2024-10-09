# frozen_string_literal: true

module Tables::ImagePage

  def image_page_table(data, **options)
    images = data.values[0]
    return if images.blank?

    images.each do |img|
      start_new_page
      image img, **options
    end
  end

end
