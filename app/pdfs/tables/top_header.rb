# frozen_string_literal: true

module Tables::TopHeader
  NORMAL_TH = {
    size: 14,
    background_color: 'eeeeee'
  }
  NORMAL_TD = {
    valign: :center
  }

  def top_header_table(data, **options)
    default_options = {
      column_widths: {
        1 => (bounds.width / data.size) * 2
      },
      position: :center,
      width: bounds.width,
      cell_style: {
        borders: [],
        padding: [5, 10, 5, 0],
        inline_format: true
      }
    }
    default_options.merge! options.slice(*BasePdf::ALLOW_OPTIONS)
    undash
    real_data = []
    data.each do |title, row|
      real_data << row.prepend(title)
    end
    table(real_data.transpose, default_options) do
      row(0).style NORMAL_TH
      row(1..-1).style NORMAL_TD
    end
  end

end
