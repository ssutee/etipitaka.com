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

ActiveRecord::Schema.define(:version => 20110513050021) do

  create_table "bookmarks", :force => true do |t|
    t.text     "note"
    t.integer  "user_id"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "books", :force => true do |t|
    t.string   "language"
    t.integer  "category"
    t.integer  "volume"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["language", "volume"], :name => "index_books_on_language_and_volume", :unique => true

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

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name",                             :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["user_name"], :name => "index_users_on_user_name"

end
