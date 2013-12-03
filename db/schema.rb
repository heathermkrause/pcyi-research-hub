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

ActiveRecord::Schema.define(:version => 20131203131807) do

  create_table "documents", :force => true do |t|
    t.string   "report_name"
    t.string   "author"
    t.string   "sponsoring_orgnization"
    t.date     "date_of_report"
    t.text     "key_recommendations"
    t.string   "key_ages"
    t.text     "notes_on_mythodology"
    t.string   "target_population"
    t.string   "data_availablity"
    t.integer  "user_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "excelsheets", :force => true do |t|
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "excelsheet_file_file_name"
    t.string   "excelsheet_file_content_type"
    t.integer  "excelsheet_file_file_size"
    t.datetime "excelsheet_file_updated_at"
  end

  create_table "keyfindings", :force => true do |t|
    t.integer  "document_id"
    t.text     "keyfinding_text"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "keyfinding_image_file_name"
    t.string   "keyfinding_image_content_type"
    t.integer  "keyfinding_image_file_size"
    t.datetime "keyfinding_image_updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.integer  "document_id"
    t.string   "keyword_text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
