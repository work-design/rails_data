# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150817095009) do

  create_table "combine_report_lists", force: :cascade do |t|
    t.integer  "combine_id"
    t.integer  "report_list_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "combine_report_lists", ["combine_id"], name: "index_combine_report_lists_on_combine_id"
  add_index "combine_report_lists", ["report_list_id"], name: "index_combine_report_lists_on_report_list_id"

  create_table "combines", force: :cascade do |t|
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.string   "reportable_name"
    t.string   "file_id"
    t.string   "file_filename"
    t.integer  "file_size"
    t.string   "file_content_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "combines", ["reportable_type", "reportable_id"], name: "index_combines_on_reportable_type_and_reportable_id"

  create_table "report_lists", force: :cascade do |t|
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.string   "reportable_name"
    t.string   "file_id"
    t.string   "file_filename"
    t.integer  "file_size"
    t.string   "file_content_type"
    t.string   "notice_email"
    t.string   "notice_body"
    t.boolean  "done"
    t.integer  "table_lists_count", default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "published"
  end

  add_index "report_lists", ["reportable_type", "reportable_id"], name: "index_report_lists_on_reportable_type_and_reportable_id"

  create_table "table_items", force: :cascade do |t|
    t.integer  "table_list_id"
    t.string   "fields",        limit: 4096
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "table_items", ["table_list_id"], name: "index_table_items_on_table_list_id"

  create_table "table_lists", force: :cascade do |t|
    t.integer  "report_list_id"
    t.string   "headers",           limit: 4096
    t.integer  "table_items_count",              default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "note_header",       limit: 4096
    t.string   "note_footer",       limit: 4096
    t.string   "footers",           limit: 2048
  end

  add_index "table_lists", ["report_list_id"], name: "index_table_lists_on_report_list_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
