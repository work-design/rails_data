# frozen_string_literal: true

module Datum
  class TopHeaderTablePdf < TablePdf

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
        row(0).style NORMAL_TH
        row(1..-1).style NORMAL_TD
      end
    end

  end
end
