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

ActiveRecord::Schema.define(version: 20150418004226) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street_line_1", limit: 255
    t.string   "street_line_2", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "ancestry",       limit: 255
    t.string   "ancestry_depth", limit: 255
  end

  add_index "categories", ["name", "ancestry"], name: "index_categories_on_name_and_ancestry", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "creditcards", force: :cascade do |t|
    t.string   "number",       limit: 255
    t.string   "name_on_card", limit: 255
    t.integer  "month",        limit: 2
    t.integer  "year",         limit: 4
    t.integer  "cvv",          limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "order_id",    limit: 4
    t.decimal  "unit_price",            precision: 12, scale: 3
    t.integer  "quantity",    limit: 4
    t.decimal  "total_price",           precision: 12, scale: 3
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",                  precision: 12, scale: 3
    t.decimal  "tax",                       precision: 12, scale: 3
    t.decimal  "shipping",                  precision: 12, scale: 3
    t.decimal  "total",                     precision: 12, scale: 3
    t.integer  "order_status_id", limit: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.date     "date"
    t.decimal  "total",                  precision: 10
    t.string   "details",    limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "postalcodes", force: :cascade do |t|
    t.string   "postalcode", limit: 255
    t.string   "city",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name",             limit: 255
    t.text     "product_long_description", limit: 65535
    t.integer  "category_id",              limit: 4
    t.integer  "quantity_per_unit",        limit: 4
    t.decimal  "unit_price",                             precision: 10
    t.decimal  "discount",                               precision: 10
    t.boolean  "discount_available",       limit: 1,                    default: false
    t.integer  "unit_weight",              limit: 4
    t.integer  "unit_in_stock",            limit: 4
    t.boolean  "product_available",        limit: 1
    t.string   "picture_url",              limit: 255
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "photo_file_name",          limit: 255
    t.string   "photo_content_type",       limit: 255
    t.integer  "photo_file_size",          limit: 4
    t.datetime "photo_updated_at"
    t.text     "short_description",        limit: 65535
  end

  add_index "products", ["category_id"], name: "fk_rails_2ad83a6e7f", using: :btree

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.decimal  "pst",                    precision: 10
    t.decimal  "gst",                    precision: 10
    t.decimal  "hst",                    precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 45, default: "customer", null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role_id",       limit: 4,   default: 2
    t.string   "first_name",    limit: 255, default: "New"
    t.string   "last_name",     limit: 255, default: "User"
    t.string   "email",         limit: 255
    t.string   "password_hash", limit: 255
    t.string   "password_salt", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "products", "categories"
end
