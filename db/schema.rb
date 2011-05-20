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

ActiveRecord::Schema.define(:version => 20110520140515) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret_token"
  end

  create_table "bookmarks", :force => true do |t|
    t.text     "note"
    t.integer  "user_id"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_number"
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

  create_table "client_applications", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "support_url"
    t.string   "callback_url"
    t.string   "key",          :limit => 40
    t.string   "secret",       :limit => 40
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_applications", ["key"], :name => "index_client_applications_on_key", :unique => true

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

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_nonces", :force => true do |t|
    t.string   "nonce"
    t.integer  "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_nonces", ["nonce", "timestamp"], :name => "index_oauth_nonces_on_nonce_and_timestamp", :unique => true

  create_table "oauth_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",                  :limit => 20
    t.integer  "client_application_id"
    t.string   "token",                 :limit => 40
    t.string   "secret",                :limit => 40
    t.string   "callback_url"
    t.string   "verifier",              :limit => 20
    t.string   "scope"
    t.datetime "authorized_at"
    t.datetime "invalidated_at"
    t.datetime "valid_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_tokens", ["token"], :name => "index_oauth_tokens_on_token", :unique => true

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

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
