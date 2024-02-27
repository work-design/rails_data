# frozen_string_literal: true

module Datum
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
      data.prepend [] if data.size <= 1
      table(data, options) do
        row(0).style NORMAL_TH
        row(1..-1).style NORMAL_TD
      end
    end

  end
end
