class RailsDataInit < ActiveRecord::Migration[5.0]

  def change

    create_table :data_lists do |t|
      t.string :title
      t.string :comment, limit: 4096
      t.string :type
      t.jsonb :parameters
      t.jsonb :columns
      t.string :data_table
      t.string :export_excel
      t.string :export_pdf
      t.timestamps
    end

    create_table :table_lists do |t|
      t.references :data_list
      t.string :headers, array: true
      t.string :footers, array: true
      t.integer :table_items_count, default: 0
      t.jsonb :parameters
      t.string :timestamp
      t.boolean :done
      t.boolean :published
      t.timestamps
    end

    create_table :table_items do |t|
      t.references :table_list
      t.string :fields, array: true
      t.timestamps
    end

    create_table :record_lists do |t|
      t.references :data_list
      t.jsonb :columns
      t.jsonb :parameters
      t.boolean :done
      t.timestamps
    end

    create_table :record_items do |t|
      t.references :record_list
      t.jsonb :fields
      t.timestamps
    end

  end

end
