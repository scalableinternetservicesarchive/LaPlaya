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

ActiveRecord::Schema.define(version: 20141203213539) do

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "user_id"
    t.boolean  "deleted",    default: false
  end

  add_index "comments", ["project_id"], name: "index_comments_on_project_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "galleries", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "thumbnail"
  end

  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id"

  create_table "galleries_projects", id: false, force: true do |t|
    t.integer "gallery_id"
    t.integer "project_id"
  end

  create_table "project_likes", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "project_likes", ["project_id", "user_id"], name: "index_project_likes_on_project_id_and_user_id", unique: true
  add_index "project_likes", ["user_id"], name: "index_project_likes_on_user_id"

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "about"
    t.text     "instructions"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "project_likes_count", default: 0, null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "starburst_announcement_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "announcement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "starburst_announcement_views", ["user_id", "announcement_id"], name: "starburst_announcement_view_index", unique: true

  create_table "starburst_announcements", force: true do |t|
    t.text     "title"
    t.text     "body"
    t.datetime "start_delivering_at"
    t.datetime "stop_delivering_at"
    t.text     "limit_to_users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "category"
  end

  create_table "taggings", force: true do |t|
    t.integer "project_id"
    t.integer "tag_id"
  end

  add_index "taggings", ["project_id"], name: "index_taggings_on_project_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggings_count", default: 0, null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
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
    t.string   "provider"
    t.string   "uid"
    t.boolean  "super_admin",            default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
