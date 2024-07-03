require 'prawn'
require 'prawn/measurement_extensions'

class BasePdf < Prawn::Document
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
    font_families['Alibaba'] = {
      bold: { file: "#{RailsData::Engine.root}/app/assets/fonts/Alibaba-PuHuiTi-Bold.ttf" },
      normal: { file: "#{RailsData::Engine.root}/app/assets/fonts/Alibaba-PuHuiTi-Regular.ttf" }
    }
    default_config.merge!(options)
    super(default_config)
    font('Alibaba')
  end

  def run
    return self unless self.empty?

    once_header beginning_data if beginning_data
    repeat_header header_data if header_data
    table_data.each_with_index do |value, index|
      start_new_page unless index == 0
      custom_table value
    end
    once_footer ending_data if ending_data
    repeat_footer footer_data if footer_data
    self
  end

  # todo hack for a bug, need confirm ?
  def empty?
    page.content.stream.length <= 2
  end

  def once_header(data = nil)

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
