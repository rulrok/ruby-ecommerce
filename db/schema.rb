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

ActiveRecord::Schema.define(version: 20150320195743) do

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

  add_foreign_key "products", "categories"
end
