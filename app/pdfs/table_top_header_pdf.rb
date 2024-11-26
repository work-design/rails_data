# frozen_string_literal: true

class TableTopHeaderPdf < TablePdf
  include Tables::TopHeader

  def custom_table(data)
    top_header_table(data)
  end

end
