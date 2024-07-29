# frozen_string_literal: true

class TableLeftHeaderPdf < TablePdf
  include Tables::LeftHeader

  def custom_table(data)
    left_header_table(data)
  end

end
