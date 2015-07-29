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

ActiveRecord::Schema.define(version: 20150729055242) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_super_admin",                     default: false, null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "call_logs", force: :cascade do |t|
    t.string   "phoneNumber",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "restaurant_id", limit: 255
    t.string   "device_type",   limit: 255
    t.string   "campus",        limit: 255
    t.integer  "device_id"
  end

  add_index "call_logs", ["device_id"], name: "index_call_logs_on_device_id"

  create_table "campuses", force: :cascade do |t|
    t.string   "name_eng",       limit: 255
    t.string   "name_kor",       limit: 255
    t.text     "description"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name_kor_short", limit: 255
    t.string   "email",          limit: 255
    t.boolean  "is_confirmed",               default: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "campus_id"
    t.string  "title"
  end

  add_index "categories", ["campus_id"], name: "index_categories_on_campus_id"

  create_table "categories_restaurants", force: :cascade do |t|
    t.integer "category_id"
    t.integer "restaurant_id"
  end

  add_index "categories_restaurants", ["category_id"], name: "index_categories_restaurants_on_category_id"
  add_index "categories_restaurants", ["restaurant_id"], name: "index_categories_restaurants_on_restaurant_id"

  create_table "devices", force: :cascade do |t|
    t.string   "uuid",        limit: 255, null: false
    t.string   "device_type", limit: 255, null: false
    t.integer  "campus_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "devices", ["campus_id"], name: "index_devices_on_campus_id"

  create_table "flyers", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flyer",         limit: 255
  end

  create_table "menus", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "section",       limit: 255
    t.string   "name",          limit: 255
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "phone_number",  limit: 255
    t.boolean  "has_flyer",                 default: false
    t.string   "flyer_path",    limit: 255, default: ""
    t.boolean  "has_coupon",                default: false
    t.text     "coupon_string", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "openingHours"
    t.float    "closingHours"
    t.boolean  "is_new",                    default: false
  end

end
