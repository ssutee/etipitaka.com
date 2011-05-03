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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110502011238) do

  create_table "items", :force => true do |t|
    t.boolean  "begin"
    t.integer  "number"
    t.integer  "section"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["number"], :name => "index_items_on_number"
  add_index "items", ["page_id", "number", "begin"], :name => "index_items_on_page_id_and_number_and_begin"
  add_index "items", ["page_id", "number", "section", "begin"], :name => "index_items_on_page_id_and_number_and_section_and_begin"
  add_index "items", ["page_id", "number", "section"], :name => "index_items_on_page_id_and_number_and_section"
  add_index "items", ["page_id", "number"], :name => "index_items_on_page_id_and_number"
  add_index "items", ["page_id"], :name => "index_items_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "language"
    t.integer  "number"
    t.text     "content"
    t.integer  "volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["language", "volume", "number"], :name => "index_pages_on_language_and_volume_and_number", :unique => true
  add_index "pages", ["language", "volume"], :name => "index_pages_on_language_and_volume"
  add_index "pages", ["language"], :name => "index_pages_on_language"
  add_index "pages", ["number"], :name => "index_pages_on_number"
  add_index "pages", ["volume"], :name => "index_pages_on_volume"

end
