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

  def run
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

  def repeat_header(data = nil)
    repeat :all do
      bounding_box [bounds.left, bounds.top + 20], width: bounds.width do
        process_header [data]
      end
    end
  end

  def process_header(data)
    default_options = {
      width: bounds.width,
      cell_style: {
        borders: [:bottom]
      }
    }
    table(data, default_options) do
      row(0).style size: 14
      row(1..-1).style size: 10
      column(0).style align: :left, padding: 0
      column(1).style align: :right, padding: 0
      cells[2, 0].style size: 12 if cells[2, 0].present?
    end

    move_down 10
  end

  def repeat_footer(data = nil)
    if data
      repeat :all do
        text_box data, at: [bounds.bottom, bounds.left + 50], align: :center
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
