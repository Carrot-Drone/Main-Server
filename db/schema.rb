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

ActiveRecord::Schema.define(version: 20150914033641) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admins", force: :cascade do |t|
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "call_logs", force: :cascade do |t|
    t.string   "phoneNumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
    t.string   "device_type"
    t.string   "campus"
    t.integer  "device_id"
    t.integer  "campus_id"
    t.integer  "user_id"
    t.integer  "category_id"
    t.boolean  "has_recent_call", default: false
  end

  add_index "call_logs", ["campus_id"], name: "index_call_logs_on_campus_id"
  add_index "call_logs", ["category_id"], name: "index_call_logs_on_category_id"
  add_index "call_logs", ["device_id"], name: "index_call_logs_on_device_id"
  add_index "call_logs", ["restaurant_id"], name: "index_call_logs_on_restaurant_id"
  add_index "call_logs", ["user_id"], name: "index_call_logs_on_user_id"

  create_table "campus_reservations", force: :cascade do |t|
    t.string   "campus_name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "campuses", force: :cascade do |t|
    t.string   "name_eng"
    t.string   "name_kor"
    t.text     "description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name_kor_short"
    t.string   "email"
    t.boolean  "is_confirmed",   default: false
    t.string   "administrator",  default: "캠퍼스:달"
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
    t.string   "uuid",        null: false
    t.string   "device_type", null: false
    t.integer  "campus_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "devices", ["campus_id"], name: "index_devices_on_campus_id"
  add_index "devices", ["user_id"], name: "index_devices_on_user_id"

  create_table "flyers", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flyer"
    t.integer  "restaurant_suggestion_id"
  end

  add_index "flyers", ["restaurant_suggestion_id"], name: "index_flyers_on_restaurant_suggestion_id"

  create_table "menus", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "section"
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description"
  end

  add_index "menus", ["restaurant_id"], name: "index_menus_on_restaurant_id"

  create_table "restaurant_corrections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.string   "major_correction"
    t.text     "details"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "is_processed",     default: false
  end

  add_index "restaurant_corrections", ["restaurant_id"], name: "index_restaurant_corrections_on_restaurant_id"
  add_index "restaurant_corrections", ["user_id"], name: "index_restaurant_corrections_on_user_id"

  create_table "restaurant_suggestions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "campus_name"
    t.string   "restaurant_name"
    t.string   "restaurant_phone_number"
    t.boolean  "is_suggested_by_restaurant"
    t.boolean  "is_processed",               default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "campus_id"
    t.string   "restaurant_office_hours"
  end

  add_index "restaurant_suggestions", ["campus_id"], name: "index_restaurant_suggestions_on_campus_id"
  add_index "restaurant_suggestions", ["user_id"], name: "index_restaurant_suggestions_on_user_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.boolean  "has_coupon",    default: false
    t.text     "notice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "opening_hours"
    t.float    "closing_hours"
    t.float    "retention"
    t.integer  "minimum_price", default: 0
    t.boolean  "is_closed",     default: false
  end

  create_table "submenus", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "submenus", ["menu_id"], name: "index_submenus_on_menu_id"

  create_table "user_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.text     "details"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_processed", default: false
  end

  add_index "user_requests", ["user_id"], name: "index_user_requests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_restaurants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.integer  "number_of_calls_for_system", default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "number_of_calls_for_user",   default: 0
    t.integer  "preference",                 default: 0
  end

  add_index "users_restaurants", ["restaurant_id"], name: "index_users_restaurants_on_restaurant_id"
  add_index "users_restaurants", ["user_id"], name: "index_users_restaurants_on_user_id"

end
