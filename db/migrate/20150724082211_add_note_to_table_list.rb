class AddNoteToTableList < ActiveRecord::Migration
  def change
    add_column :table_lists, :note_header, :string, limit: 4096
    add_column :table_lists, :note_footer, :string, limit: 4096
  end
end
