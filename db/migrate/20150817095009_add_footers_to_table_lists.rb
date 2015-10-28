class AddFootersToTableLists < ActiveRecord::Migration
  def change
    add_column :table_lists, :footers, :string, limit: 2048
  end
end
