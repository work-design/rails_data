# frozen_string_literal: true

module Tables::Content

  # 针对文字内容
  def content_table(data, options = {})
    return if data.blank?
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
    table(data, default_options) do
      row(0..-1).style NORMAL_TD
    end
  end

end
