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

ActiveRecord::Schema.define(version: 20160130195907) do

  create_table "apartments", force: :cascade do |t|
    t.text     "address",      limit: 65535
    t.text     "apartment_no", limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "community_id", limit: 4
    t.date     "moved"
  end

  add_index "apartments", ["community_id"], name: "index_apartments_on_community_id", using: :btree

  create_table "communities", force: :cascade do |t|
    t.text     "name",        limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "fee_rates", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "rate_apartment",           precision: 10
    t.decimal  "rate_cost",                precision: 10
    t.integer  "fee_id",         limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "fee_rates", ["fee_id"], name: "index_fee_rates_on_fee_id", using: :btree

  create_table "fee_transactions", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "transaction_type", limit: 255
    t.decimal  "value",                        precision: 10
    t.integer  "fee_id",           limit: 4
    t.integer  "apartment_id",     limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "fee_transactions", ["apartment_id"], name: "index_fee_transactions_on_apartment_id", using: :btree
  add_index "fee_transactions", ["fee_id"], name: "index_fee_transactions_on_fee_id", using: :btree

  create_table "fees", force: :cascade do |t|
    t.text     "name",             limit: 65535
    t.integer  "fee_type",         limit: 4
    t.string   "currency",         limit: 255
    t.string   "unit",             limit: 255
    t.integer  "community_id",     limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "payment_interval", limit: 255
  end

  add_index "fees", ["community_id"], name: "index_fees_on_community_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",  null: false
    t.string   "encrypted_password",     limit: 255, default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "user_type",              limit: 255, default: "0"
    t.integer  "apartment_id",           limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "phone",                  limit: 255
    t.string   "mobile",                 limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "fee_rates", "fees"
  add_foreign_key "fee_transactions", "apartments"
  add_foreign_key "fee_transactions", "fees"
  add_foreign_key "fees", "communities"
end
