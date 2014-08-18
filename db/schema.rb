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

ActiveRecord::Schema.define(version: 20130821081150) do

  create_table "content_packs", force: true do |t|
    t.string   "name",            limit: 256
    t.string   "description",     limit: 1024
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "content_type_id"
    t.integer  "status_id"
  end

  add_index "content_packs", ["content_type_id"], name: "fk_content_packs_content_types", using: :btree
  add_index "content_packs", ["status_id"], name: "fk_content_packs_statuses", using: :btree
  add_index "content_packs", ["user_id"], name: "fk_content_packs_users", using: :btree

  create_table "content_types", force: true do |t|
    t.string "name"
  end

  create_table "selections", force: true do |t|
    t.string   "title",                  limit: 256,  null: false
    t.string   "grade_equivalent_level"
    t.string   "lexile_level"
    t.string   "guided_reading_level"
    t.integer  "wcpm_target"
    t.boolean  "internationally"
    t.string   "description",            limit: 1024
    t.string   "cover_image"
    t.string   "author"
    t.string   "illustrator"
    t.string   "publisher"
    t.string   "intro_text"
    t.string   "intro_audio"
    t.boolean  "error"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updater_id"
    t.integer  "topic_id"
    t.integer  "priority"
  end

  add_index "selections", ["status_id"], name: "fk_selections_statuses", using: :btree
  add_index "selections", ["topic_id"], name: "fk_selections_topics", using: :btree
  add_index "selections", ["updater_id"], name: "fk_selections_users", using: :btree

  create_table "statuses", force: true do |t|
    t.string "name"
  end

  create_table "topics", force: true do |t|
    t.string   "name",            limit: 256, null: false
    t.string   "grade_level",     limit: 10
    t.boolean  "default"
    t.integer  "content_pack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  add_index "topics", ["content_pack_id"], name: "fk_topics_content_packs", using: :btree

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
