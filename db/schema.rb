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

ActiveRecord::Schema.define(version: 20131230184704) do

  create_table "accounts", force: true do |t|
    t.string "name",              null: false
    t.string "account_id",        null: false
    t.string "access_key_id",     null: false
    t.string "secret_access_key", null: false
    t.string "region",            null: false
    t.string "bucket_name",       null: false
  end

  create_table "availability_zones", force: true do |t|
    t.string "name", null: false
  end

  add_index "availability_zones", ["name"], name: "index_availability_zones_on_name", unique: true, using: :btree

  create_table "products", force: true do |t|
    t.string "code", null: false
    t.string "name", null: false
  end

  add_index "products", ["code"], name: "index_products_on_code", unique: true, using: :btree

  create_table "usage_types", force: true do |t|
    t.string "name", null: false
  end

  add_index "usage_types", ["name"], name: "index_usage_types_on_name", unique: true, using: :btree

end
