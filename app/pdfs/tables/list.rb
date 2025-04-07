# frozen_string_literal: true

module Tables::List

  def list_table(data, **options)
    return if data.blank?

    data.each do |i|
      move_down 25
      text i, inline_format: true
    end
  end

end
