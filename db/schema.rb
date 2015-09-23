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

ActiveRecord::Schema.define(version: 20150923014937) do

  create_table "answers", force: :cascade do |t|
    t.integer  "member_id",   limit: 4
    t.integer  "question_id", limit: 4
    t.integer  "score",       limit: 1
    t.string   "body",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["member_id"], name: "index_answers_on_member_id", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "members", ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true, using: :btree
  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree

  create_table "need_answer_members", force: :cascade do |t|
    t.integer  "from_member_id", limit: 4, null: false
    t.integer  "to_member_id",   limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "need_answer_members", ["from_member_id"], name: "index_need_answer_members_on_from_member_id", using: :btree
  add_index "need_answer_members", ["to_member_id"], name: "index_need_answer_members_on_to_member_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "question_type", limit: 1,   default: 1, null: false
    t.string   "subtitle",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
