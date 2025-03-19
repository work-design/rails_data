require 'prawn'
require 'prawn/measurement_extensions'

class BasePdf < Prawn::Document
  FONT = {
    'Alibaba' => {
      bold: { file: "#{RailsData::Engine.root}/app/assets/fonts/Alibaba-PuHuiTi-Bold.ttf" },
      normal: { file: "#{RailsData::Engine.root}/app/assets/fonts/Alibaba-PuHuiTi-Regular.ttf" }
    },
    'DingTalk' => {
      normal: { file: "#{RailsData::Engine.root}/app/assets/fonts/DingTalk-JinBuTi.ttf" }
    }
  }
  ALLOW_OPTIONS = [:position, :column_widths, :width, :row_colors, :cell_style]
  attr_accessor(
    :title,
    :table_data,
    :header_data,
    :ending_data,
    :ending_data_image,
    :footer_data,
    :beginning_data
  )

  def initialize(font: FONT.keys[0], **options)
    default_config = {
      page_size: 'A4'
    }
    font_families.merge! FONT
    default_config.merge!(options)
    super(default_config)
    font(font)
  end

  def run(**options)
  end

  # todo hack for a bug, need confirm ?
  def empty?
    page.content.stream.length <= 2
  end

  def once_header(value = beginning_data)
    case value
    when String
      font_size(14) { text value }
    when Hash
      value.each do |k, v|
        formatted_text(
          [
            { text: "#{k.to_s}: ", styles: [:bold] },
            { text: v }
          ]
        )
      end
    when Array
      value.each do |text|
        formatted_text [text]
      end
    else
      text value
    end
  end

  def once_footer(value = ending_data)
    case value
    when String
      font_size(14) { text value }
    when Hash
      value.each do |k, v|
        formatted_text(
          [
            { text: "#{k.to_s}: ", styles: [:bold] },
            { text: v }
          ]
        )
      end
    when Array
      formatted_text value
    else
      text value
    end
  end

  def fullwidth_header
    repeat :all do
      canvas do

      end
    end
  end

  def repeat_header(data = nil, **options)
    repeat :all do
      bounding_box [bounds.left, bounds.top + 20], width: bounds.width do
        process_header [data], **options
      end
    end
  end

  def process_header(data, size: 14, **options)
    half_size = size / 2
    default_options = {
      width: bounds.width,
      cell_style: {
        borders: [:bottom]
      },
      **options
    }

    table(data, default_options) do
      row(0).style size: size
      row(1..-1).style size: 10
      if column_length == 1
        column(0).style align: :center
      elsif column_length == 2
        column(0).style align: :left, padding: [half_size, 0]
        column(1).style align: :right, padding: [half_size, 0]
      elsif column_length == 3
        column(0).style align: :left, padding: [half_size, 0]
        column(1).style align: :center, padding: [half_size, 0]
        column(-1).style align: :right, padding: [half_size, 0]
      end
    end

    move_down size
  end

  def key_value_header
    #cells[2, 0].style size: 12 if cells[2, 0].present?
  end

  def repeat_footer(data = nil)
    if data
      repeat :all do
        text_box data, at: [bounds.bottom, bounds.left + 50], align: :center
      end
    end
    page_footer
  end

  def repeat_footer_image(data = nil)
    if data
      repeat :all do
        bounding_box [bounds.left, bounds.bottom + 120], width: bounds.width, height: 90 do
          image data[0], height: 90
        end if data[0]
        bounding_box [bounds.left + 150, bounds.bottom + 120], width: bounds.width, height: 90 do
          image data[1], height: 90
        end if data[1]
        bounding_box [bounds.left + 300, bounds.bottom + 120], width: bounds.width, height: 90 do
          image data[2], height: 90
        end if data[2]
      end
    end
    page_footer
  end

  def deal_text(data)
  end

  def page_footer
    number_pages '<page> / <total>', at: [bounds.bottom, 0], align: :right
  end

end
