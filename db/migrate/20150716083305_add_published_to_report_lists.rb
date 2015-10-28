class AddPublishedToReportLists < ActiveRecord::Migration
  def change
    add_column :report_lists, :published, :boolean
  end
end
