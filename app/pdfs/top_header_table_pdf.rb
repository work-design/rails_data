# frozen_string_literal: true

class TopHeaderTablePdf < TablePdf

  def custom_table(data)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        border_lines: [:solid, :solid, :solid, :solid]
      }
    }
    undash
    table(data, options) do
      if data.size > 1
        row(0).style NORMAL_TH
        row(1..-1).style NORMAL_TD
      else
        row(0..-1).style NORMAL_TD
      end
    end
  end

end
