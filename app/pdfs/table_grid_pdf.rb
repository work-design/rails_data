# frozen_string_literal: true

class TableGridPdf < TablePdf

  # 针对数据
  def custom_table(data, options = {})
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

end
