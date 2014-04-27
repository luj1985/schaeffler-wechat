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

ActiveRecord::Schema.define(version: 13) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "href"
  end

  create_table "lotteries", force: true do |t|
    t.string   "level"
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "serial"
    t.string   "crypted_serial"
    t.integer  "user_id"
    t.string   "status"
  end

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "text"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "openid"
    t.string   "tel"
    t.string   "name"
    t.string   "workshop"
    t.text     "workshop_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "join_match"
  end

end
