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

ActiveRecord::Schema.define(version: 20140106060141) do

  create_table "journals", force: true do |t|
    t.integer  "user_id"
    t.integer  "journable_id"
    t.string   "journable_type"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_logs", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_logs", ["task_id"], name: "index_task_logs_on_task_id", using: :btree
  add_index "task_logs", ["user_id"], name: "index_task_logs_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.date     "start_date"
    t.string   "status",     default: "inactive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_potentials", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "display_name"
    t.string   "fb_access_token"
    t.string   "profile_picture"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
