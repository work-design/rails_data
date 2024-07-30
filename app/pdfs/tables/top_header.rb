# frozen_string_literal: true

module Tables::TopHeader
  NORMAL_TH = {
    align: :center,
    size: 14,
    font_style: :bold,
    background_color: 'eeeeee'
  }
  NORMAL_TD = {
    size: 12,
    valign: :center
  }

  def top_header_table(data, thead = nil)
    options = {
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: []
      }
    }
    undash
    real_data = data
    real_data.prepend(thead) if thead.present?
    table(real_data, options) do
      if thead.present?
        row(0).style NORMAL_TH
        row(1..-1).style NORMAL_TD
      else
        row(0..-1).style NORMAL_TD
      end
    end
  end

end
