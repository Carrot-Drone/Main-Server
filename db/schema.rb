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

ActiveRecord::Schema.define(version: 20150303052403) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_super_admin",         default: false, null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_tags", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "admin_id"
  end

  add_index "admins_tags", ["admin_id"], name: "index_admins_tags_on_admin_id", using: :btree
  add_index "admins_tags", ["tag_id"], name: "index_admins_tags_on_tag_id", using: :btree

  create_table "call_logs", force: true do |t|
    t.string   "phoneNumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "restaurant_id"
    t.string   "device_type"
    t.string   "campus"
    t.integer  "device_id"
  end

  add_index "call_logs", ["device_id"], name: "index_call_logs_on_device_id", using: :btree

  create_table "campuses", force: true do |t|
    t.string   "name_eng"
    t.string   "name_kor"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name_kor_short"
    t.string   "email"
    t.boolean  "is_confirmed",   default: false
  end

  create_table "devices", force: true do |t|
    t.string   "uuid",        null: false
    t.string   "device_type", null: false
    t.integer  "campus_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "devices", ["campus_id"], name: "index_devices_on_campus_id", using: :btree

  create_table "flyers", force: true do |t|
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flyer"
  end

  create_table "menus", force: true do |t|
    t.integer  "restaurant_id"
    t.string   "section"
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.boolean  "has_flyer",     default: false
    t.string   "flyer_path",    default: ""
    t.boolean  "has_coupon",    default: false
    t.text     "coupon_string"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "campus"
    t.text     "phone_numbers"
    t.string   "category"
    t.float    "openingHours"
    t.float    "closingHours"
    t.boolean  "is_new",        default: false
    t.integer  "campus_id"
  end

  add_index "restaurants", ["campus_id"], name: "index_restaurants_on_campus_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
