class RailsDataInit < ActiveRecord::Migration[5.0]

  def change
    create_table :data_lists do |t|
      t.string :title
      t.string :comment, limit: 4096
      t.string :type
      if connection.adapter_name == 'PostgreSQL'
        t.jsonb :parameters
        t.jsonb :columns
      else
        t.json :parameters
        t.json :columns
      end
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
      if connection.adapter_name == 'PostgreSQL'
        t.jsonb :parameters
      else
        t.json :parameters
      end
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
      if connection.adapter_name == 'PostgreSQL'
        t.jsonb :columns
        t.jsonb :parameters
      else
        t.json :columns
        t.json :parameters
      end
      t.boolean :done
      t.timestamps
    end

    create_table :record_items do |t|
      t.references :record_list
      if connection.adapter_name == 'PostgreSQL'
        t.jsonb :fields
      else
        t.json :fields
      end
      t.timestamps
    end
  end

end
