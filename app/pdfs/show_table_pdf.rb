# frozen_string_literal: true

class ShowTablePdf < TablePdf
  NORMAL_TH = {
    background_color: 'eeeeee',
    size: 14,
    valign: :center,
    padding: 0
  }

  def custom_table(data)
    options = {
      column_widths: { 0 => 14 * 8 , 2 => 14 * 8 - 2 },
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [:top, :bottom],
        border_width: 0.5,
        border_lines: [:solid, :solid, :solid, :solid]
      }
    }
    undash
    _data = data.flatten.in_groups_of(4)
    table(_data, options) do
      columns(0).style NORMAL_TH
      columns(1).style NORMAL_TD
      columns(2).style NORMAL_TH
      columns(3).style NORMAL_TD
    end
  end

end
