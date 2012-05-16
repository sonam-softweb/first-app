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

ActiveRecord::Schema.define(:version => 20120515135127) do

  create_table "bids", :force => true do |t|
    t.decimal  "amount",      :precision => 10, :scale => 2
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.integer  "loan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "borrowers", :force => true do |t|
    t.string   "status",                                            :default => "Under Review"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "screen_name"
    t.string   "email"
    t.string   "headline"
    t.string   "description"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.string   "ss"
    t.string   "cc_number"
    t.string   "cc_expiration"
    t.string   "cc_cid"
    t.string   "bank_account"
    t.string   "bank_routing"
    t.string   "system_size"
    t.string   "system_price"
    t.string   "csun_ranking"
    t.string   "password"
    t.text     "our_notes"
    t.datetime "approval_date"
    t.datetime "expiration_date"
    t.integer  "installer_id"
    t.decimal  "monthly_payment",    :precision => 10, :scale => 2
    t.string   "nfp_category"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "due_borrower_payments", :force => true do |t|
    t.integer  "borrower_id"
    t.decimal  "due_amount",  :precision => 10, :scale => 2
    t.date     "due_date"
    t.boolean  "processed",                                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_lists", :force => true do |t|
    t.string   "list_name"
    t.string   "list_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_share_projects", :force => true do |t|
    t.string   "from_name"
    t.string   "from_email"
    t.string   "to_name"
    t.string   "to_email"
    t.string   "message"
    t.integer  "borrower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_subscribers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "zip_code"
    t.integer  "email_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "installers", :force => true do |t|
    t.string   "status",               :default => "Under Review"
    t.string   "company_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "website"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.text     "applicant_comments"
    t.text     "our_notes"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "client_id_pg"
    t.integer  "payment_method_id_pg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lenders", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "screen_name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "ss"
    t.string   "bank_account"
    t.string   "bank_routing"
    t.text     "our_notes"
    t.float    "bank_balance",   :default => 0.0
    t.string   "status",         :default => "Under Review"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", :force => true do |t|
    t.integer  "borrower_id"
    t.integer  "lender_id"
    t.decimal  "lender_percentage", :precision => 7, :scale => 6
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managers", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "borrower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "projects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "received_borrower_payments", :force => true do |t|
    t.integer  "borrower_id"
    t.decimal  "received_amount", :precision => 10, :scale => 2
    t.date     "received_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_rights", :force => true do |t|
    t.integer  "user_id"
    t.integer  "borrower_id"
    t.integer  "lender_id"
    t.integer  "installer_id"
    t.integer  "manager_id"
    t.string   "security_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token"
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

end
