require 'prawn'
require 'prawn/measurement_extensions'

class BasePdf < Prawn::Document
  FONT = {
    'Alibaba' => {
      bold: { file: "#{RailsData::Engine.root}/app/assets/fonts/Alibaba-PuHuiTi-Bold.ttf" },
      normal: { file: "#{RailsData::Engine.root}/app/assets/fonts/Alibaba-PuHuiTi-Regular.ttf" }
    }
  }
  attr_accessor(
    :title,
    :table_data,
    :header_data,
    :ending_data,
    :footer_data,
    :beginning_data
  )

  def initialize(**options)
    default_config = {
      page_size: 'A4'
    }
    font_families.merge! FONT
    default_config.merge!(options)
    super(default_config)
    font(FONT.keys[0])
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
      font(FONT.keys[0], style: :bold, size: 20) { text value }
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

  def repeat_header(data = nil)
    repeat :all do
      canvas do
        bounding_box [bounds.left+75, bounds.top-20], :width  => bounds.width do
          process_header(data)
        end
      end
    end
  end

  def process_header(data)
    default_options = {
      cell_style: { borders: [] },
      column_widths: [225, 220]
    }

    table(data, default_options) do
      row(0).style font_style: :bold, size: 14
      row(1..-1).style size: 10
      column(0).style align: :left, padding: 0
      column(1).style align: :right, padding: 0
      cells[2, 0].style size: 12 if cells[2, 0].present?
    end

    move_down 50
  end

  def once_footer(data = nil)
    text data if data
    number_pages "<page> / <total>", at: [bounds.right - 50, 0]
  end

  def deal_text(data)

  end

  def repeat_footer(data)

  end

end
