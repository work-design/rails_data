# frozen_string_literal: true

module Tables::List

  def list_table(data, **options)
    stroke_color 'eeeeee'
    stroke do
      horizontal_rule
    end
    data.each do |i|
      move_down 25
      text i, inline_format: true
    end
  end

end
