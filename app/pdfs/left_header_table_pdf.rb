# frozen_string_literal: true

class LeftHeaderTablePdf < TablePdf
  NORMAL_TH = {
    background_color: 'eeeeee'
  }

  def custom_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [:top, :bottom],
        border_width: 0.5,
        border_lines: [:solid, :solid, :solid, :solid]
      }
    }
    undash
    table(data, options) do
      columns(0).style NORMAL_TH
      columns(1..-1).style NORMAL_TD
    end
  end

end
