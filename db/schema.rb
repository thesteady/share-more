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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130601002340) do

  create_table "access_tokens", :force => true do |t|
    t.string   "token"
    t.string   "secret"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "access_tokens", ["user_id"], :name => "index_access_tokens_on_user_id"

  create_table "api_keys", :force => true do |t|
    t.string   "access_token"
    t.integer  "author_id"
    t.boolean  "expired"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  add_index "api_keys", ["user_id"], :name => "index_api_keys_on_user_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "published"
    t.string   "unique_url"
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "revisions", :force => true do |t|
    t.text     "body"
    t.integer  "article_id"
    t.integer  "published"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "revisions", ["article_id"], :name => "index_revisions_on_article_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "full_name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "twitter_id"
  end

  add_index "users", ["twitter_id"], :name => "index_users_on_twitter_id"

end
