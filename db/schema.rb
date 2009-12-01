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

ActiveRecord::Schema.define(:version => 20080831192939) do

  create_table "bills", :force => true do |t|
    t.string   "description"
    t.float    "amount"
    t.date     "made_on"
    t.boolean  "loan",        :null => false
    t.integer  "currency_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["loan"], :name => "index_bills_on_loan"
  add_index "bills", ["made_on"], :name => "index_bills_on_made_on"

  create_table "currencies", :force => true do |t|
    t.string "name",          :null => false
    t.string "monetary_code"
  end

  add_index "currencies", ["monetary_code"], :name => "index_currencies_on_monetary_code", :unique => true

  create_table "participations", :force => true do |t|
    t.integer  "bill_id",     :null => false
    t.integer  "user_id",     :null => false
    t.integer  "currency_id", :null => false
    t.float    "amount",      :null => false
    t.boolean  "payer",       :null => false
    t.boolean  "fixed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["bill_id"], :name => "index_participations_on_bill_id"
  add_index "participations", ["payer"], :name => "index_participations_on_payer"
  add_index "participations", ["user_id"], :name => "index_participations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email", "password_hash"], :name => "index_users_on_email_and_password_hash"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
