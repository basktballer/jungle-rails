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

ActiveRecord::Schema.define(version: 20190517171718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.date    "created_on"
    t.string  "text",        limit: 255
    t.integer "user_id",     limit: 8
    t.integer "resource_id", limit: 8
  end

  add_index "comments", ["resource_id"], name: "comments_resource_id_index", using: :btree
  add_index "comments", ["user_id"], name: "comments_user_id_index", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "item_price_cents"
    t.integer  "total_price_cents"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "migrations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "batch"
    t.datetime "migration_time"
  end

  create_table "migrations_lock", id: false, force: :cascade do |t|
    t.integer "is_locked"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "total_cents"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "stripe_charge_id"
    t.string   "email"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "price_cents"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer "rate"
  end

  create_table "resources", force: :cascade do |t|
    t.string  "url",         limit: 255
    t.string  "title",       limit: 255
    t.string  "description", limit: 255
    t.date    "created_on"
    t.integer "created_by",  limit: 8
    t.integer "category_id", limit: 8
  end

  add_index "resources", ["category_id"], name: "resources_category_id_index", using: :btree
  add_index "resources", ["created_by"], name: "resources_created_by_index", using: :btree
  add_index "resources", ["url", "title", "description"], name: "search", using: :btree

  create_table "resources_references", force: :cascade do |t|
    t.integer "resource_id", limit: 8
    t.integer "user_id",     limit: 8
    t.integer "rate_id",     limit: 8
    t.boolean "liked"
  end

  add_index "resources_references", ["rate_id"], name: "resources_references_rate_id_index", using: :btree
  add_index "resources_references", ["resource_id"], name: "resources_references_resource_id_index", using: :btree
  add_index "resources_references", ["user_id"], name: "resources_references_user_id_index", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "comments", "resources", name: "comments_resource_id_foreign", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "resources_references", "rates", name: "resources_references_rate_id_foreign", on_delete: :cascade
  add_foreign_key "resources_references", "resources", name: "resources_references_resource_id_foreign", on_delete: :cascade
end
