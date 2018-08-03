module PdfTableHelper
  NORMAL_TH = {
    align: :center,
    valign: :center,
    size: 14,
    font_style: :bold,
    height: 30,
    background_color: 'eeeeee'
  }
  NORMAL_TD = {
    align: :left,
    valign: :center,
    size: 12,
    height: 30
  }
  LEFT_TD = {
    align: :left,
    valign: :center,
    size: 12
  }
  RIGHT_TD = {
    align: :right,
    valign: :center,
    size: 12
  }

  def left_header_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :dashed, :solid]
      }
    }
    undash
    table(data, options) do
      columns(0).style NORMAL_TH
      columns(1..-1).style NORMAL_TD
    end
  end

  def top_header_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :dashed, :solid]
      }
    }
    undash
    table(data, options) do
      row(0).style NORMAL_TH
      row(1..-1).style NORMAL_TD
    end
  end

  def grid_table(data, options = {})
    default_options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: []
      }
    }
    default_options.merge!(options)
    undash
    table(data, default_options) do
      columns(0).style LEFT_TD
      columns(-1).style RIGHT_TD
    end
  end

  def content_table(data, options = {}, &block)
    default_options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :solid, :solid],
        border_color: '999999'
      }
    }
    default_options.merge!(options)
    undash
    if block_given?
      table(data, default_options, &block)
    else
      table(data, default_options) do
        row(0..-1).style NORMAL_TD
      end
    end
  end

  def footer_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: []
      }
    }
    undash
    table(data, options) do
      columns(0..-1).style NORMAL_TD
    end
  end

end