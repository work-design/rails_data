class CreateReportLists < ActiveRecord::Migration

  def change

    create_table "data_lists", :force => true do |t|
      t.string   "file_id"
      t.string   "file_filename"
      t.integer  "file_size"
      t.string   "file_content_type"
      t.string   "notice_email"
      t.string   "notice_body"
      t.boolean  "done"
      t.integer  "table_lists_count", :default => 0
      t.datetime "created_at",                       :null => false
      t.datetime "updated_at",                       :null => false
    end

    add_index :report_lists, [:reportable_type, :reportable_id]

    create_table "table_lists", :force => true do |t|
      t.integer  "report_list_id"
      t.string   "headers", limit: 4096
      t.integer  "table_items_count", default: 0
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end

    add_index :table_lists, :report_list_id

    create_table "table_items", :force => true do |t|
      t.integer  "table_list_id"
      t.string   "fields", limit: 4096
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end

    add_index :table_items, :table_list_id

    create_table "combines", :force => true do |t|
      t.integer  "reportable_id"
      t.string   "reportable_type"
      t.string   "reportable_name"
      t.string   "file_id"
      t.string   "file_filename"
      t.integer  "file_size"
      t.string   "file_content_type"
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end

    add_index :combines, [:reportable_type, :reportable_id]

    create_table "combine_report_lists", :force => true do |t|
      t.integer  "combine_id"
      t.integer  "report_list_id"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    add_index :combine_report_lists, :combine_id
    add_index :combine_report_lists, :report_list_id

  end

end
