# frozen_string_literal: true

class LeftHeaderTablePdf < TablePdf

  def custom_table(data)
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

end
