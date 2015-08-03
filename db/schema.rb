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

ActiveRecord::Schema.define(version: 20150803180536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "category_items", force: :cascade do |t|
    t.integer "category_id"
    t.integer "item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "retired",     default: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity",        default: 1
    t.integer "item_id"
    t.decimal "price"
    t.integer "item_group_id"
    t.string  "item_group_type"
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "ordered"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "display_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "order_items", "items"
end
