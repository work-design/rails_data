class CreateReportLists < ActiveRecord::Migration

  def change

    create_table :data_lists do |t|
      t.string :file_id
      t.string :file_filename
      t.integer :file_size
      t.string :file_content_type
      t.boolean :done
      t.boolean :published
      t.integer :table_lists_count, default: 0
      t.timestamps
    end

    create_table :table_lists do |t|
      t.references :data_list
      t.string :headers, limit: 4096
      t.string :footers, limit: 4096
      t.string :note_header, limit: 4096
      t.string :note_footer, limit: 4096
      t.integer :table_items_count, default: 0
      t.timestamps
    end

    create_table :table_items do |t|
      t.references :table_list
      t.string :fields, limit: 4096
      t.timestamps
    end

  end

end
