# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100811192110) do

  create_table "bills", :force => true do |t|
    t.text     "description"
    t.float    "amount"
    t.datetime "date"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debts", :force => true do |t|
    t.float    "amount"
    t.integer  "bill_id"
    t.integer  "person_from_id"
    t.integer  "person_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false, :null => false
  end

  add_index "people", ["email"], :name => "index_people_on_email"
  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

end
