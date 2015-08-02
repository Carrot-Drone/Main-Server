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

ActiveRecord::Schema.define(version: 20150802164840) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_super_admin",                     default: false, null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "call_logs", force: :cascade do |t|
    t.string   "phoneNumber",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id", limit: 4
    t.string   "device_type",   limit: 255
    t.string   "campus",        limit: 255
    t.integer  "device_id",     limit: 4
    t.integer  "campus_id",     limit: 4
    t.integer  "user_id",       limit: 4
    t.integer  "category_id",   limit: 4
  end

  add_index "call_logs", ["campus_id"], name: "index_call_logs_on_campus_id", using: :btree
  add_index "call_logs", ["category_id"], name: "index_call_logs_on_category_id", using: :btree
  add_index "call_logs", ["device_id"], name: "index_call_logs_on_device_id", using: :btree
  add_index "call_logs", ["restaurant_id"], name: "index_call_logs_on_restaurant_id", using: :btree
  add_index "call_logs", ["user_id"], name: "index_call_logs_on_user_id", using: :btree

  create_table "campus_has_popup", id: false, force: :cascade do |t|
    t.integer "campuses_id", limit: 4,                null: false
    t.integer "popup_id",    limit: 4,                null: false
    t.boolean "status",                default: true, null: false
  end

  add_index "campus_has_popup", ["campuses_id"], name: "fk_campuses_has_popup_campuses_idx", using: :btree
  add_index "campus_has_popup", ["popup_id"], name: "fk_campuses_has_popup_popup1_idx", using: :btree

  create_table "campus_reservations", force: :cascade do |t|
    t.string   "campus_name",  limit: 255
    t.string   "phone_number", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "campuses", force: :cascade do |t|
    t.string   "name_eng",       limit: 255
    t.string   "name_kor",       limit: 255
    t.text     "description",    limit: 65535
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "name_kor_short", limit: 255
    t.string   "email",          limit: 255
    t.boolean  "is_confirmed",                 default: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "campus_id", limit: 4
    t.string  "title",     limit: 255
  end

  add_index "categories", ["campus_id"], name: "index_categories_on_campus_id", using: :btree

  create_table "categories_restaurants", force: :cascade do |t|
    t.integer "category_id",   limit: 4
    t.integer "restaurant_id", limit: 4
  end

  add_index "categories_restaurants", ["category_id"], name: "index_categories_restaurants_on_category_id", using: :btree
  add_index "categories_restaurants", ["restaurant_id"], name: "index_categories_restaurants_on_restaurant_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "uuid",        limit: 255, null: false
    t.string   "device_type", limit: 255, null: false
    t.integer  "campus_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "devices", ["campus_id"], name: "index_devices_on_campus_id", using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "flyers", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flyer",         limit: 255
  end

  create_table "menus", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.string   "section",       limit: 255
    t.string   "name",          limit: 255
    t.integer  "price",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",      limit: 4
    t.text     "description",   limit: 65535
  end

  create_table "popup", force: :cascade do |t|
    t.string   "external_link", limit: 255
    t.text     "description",   limit: 255
    t.datetime "created_at",                null: false
  end

  create_table "popup_has_device", id: false, force: :cascade do |t|
    t.integer  "popup_id",      limit: 4,             null: false
    t.integer  "devices_id",    limit: 4,             null: false
    t.string   "status",        limit: 9,             null: false
    t.datetime "requestTime",                         null: false
    t.integer  "responseAfter", limit: 4, default: 0
  end

  add_index "popup_has_device", ["devices_id"], name: "fk_popup_has_devices_devices1_idx", using: :btree
  add_index "popup_has_device", ["popup_id"], name: "fk_popup_has_devices_popup1_idx", using: :btree

  create_table "restaurant_corrections", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "restaurant_id",    limit: 4
    t.string   "major_correction", limit: 255
    t.text     "details",          limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "restaurant_corrections", ["restaurant_id"], name: "index_restaurant_corrections_on_restaurant_id", using: :btree
  add_index "restaurant_corrections", ["user_id"], name: "index_restaurant_corrections_on_user_id", using: :btree

  create_table "restaurant_suggestions", force: :cascade do |t|
    t.integer  "user_id",                    limit: 4
    t.string   "campus_name",                limit: 255
    t.string   "restaurant_name",            limit: 255
    t.string   "restaurant_phone_number",    limit: 255
    t.string   "restaurant_opening_hours",   limit: 255
    t.string   "restaurant_closing_hours",   limit: 255
    t.boolean  "is_suggested_by_restaurant"
    t.boolean  "is_processed",                           default: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "campus_id",                  limit: 4
  end

  add_index "restaurant_suggestions", ["campus_id"], name: "index_restaurant_suggestions_on_campus_id", using: :btree
  add_index "restaurant_suggestions", ["user_id"], name: "index_restaurant_suggestions_on_user_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "phone_number",  limit: 255
    t.boolean  "has_coupon",                  default: false
    t.text     "coupon_string", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "openingHours",  limit: 24
    t.float    "closingHours",  limit: 24
    t.boolean  "is_new",                      default: false
    t.float    "retention",     limit: 24
  end

  create_table "submenus", force: :cascade do |t|
    t.integer  "menu_id",    limit: 4
    t.string   "name",       limit: 255
    t.integer  "price",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "submenus", ["menu_id"], name: "index_submenus_on_menu_id", using: :btree

  create_table "user_requests", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "email",      limit: 255
    t.text     "details",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_requests", ["user_id"], name: "index_user_requests_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_restaurants", force: :cascade do |t|
    t.integer  "user_id",                    limit: 4
    t.integer  "restaurant_id",              limit: 4
    t.integer  "number_of_calls_for_system", limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "number_of_calls_for_user",   limit: 4
    t.integer  "preference",                 limit: 4, default: 0
  end

  add_index "users_restaurants", ["restaurant_id"], name: "index_users_restaurants_on_restaurant_id", using: :btree
  add_index "users_restaurants", ["user_id"], name: "index_users_restaurants_on_user_id", using: :btree

  add_foreign_key "campus_has_popup", "campuses", column: "campuses_id", name: "fk_campuses_has_popup_campuses"
  add_foreign_key "campus_has_popup", "popup", name: "fk_campuses_has_popup_popup1"
  add_foreign_key "popup_has_device", "devices", column: "devices_id", name: "fk_popup_has_devices_devices1"
  add_foreign_key "popup_has_device", "popup", name: "fk_popup_has_devices_popup1"
end
