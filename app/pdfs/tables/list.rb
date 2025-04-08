# frozen_string_literal: true

module Tables::List

  def list_table(data, **options)
    stroke_color 'dddddd'
    stroke do
      horizontal_rule
    end
    data.each do |i|
      move_down 25
      if i.is_a? Array
        i.each do |sub_i|
          text sub_i, inline_format: true
        end
      else
        text i, inline_format: true
      end
    end
  end

end
