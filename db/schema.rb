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

ActiveRecord::Schema.define(version: 20141113053817) do


  create_table "challenges", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.date     "start"
    t.date     "stop"
    t.integer  "sport"
    t.integer  "distance"
    t.integer  "category"
  end

  create_table "comments", force: true do |t|
    t.text     "message"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["challenge_id"], name: "index_comments_on_challenge_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "participations", force: true do |t|
    t.integer  "challenge_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["challenge_id"], name: "index_participations_on_challenge_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "progresses", force: true do |t|
    t.string   "gain"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participation_id"
  end

  add_index "progresses", ["challenge_id"], name: "index_progresses_on_challenge_id"
  add_index "progresses", ["participation_id"], name: "index_progresses_on_participation_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
