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

ActiveRecord::Schema.define(version: 20150814000536) do

  create_table "giveaways_ballots", force: :cascade do |t|
    t.integer  "entrant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "giveaways_ballots", ["entrant_id"], name: "index_giveaways_ballots_on_entrant_id"

  create_table "giveaways_entrants", force: :cascade do |t|
    t.integer  "giveaway_id"
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "confirmation_token"
    t.boolean  "confirmed_email",    default: false
    t.string   "referral_token"
    t.boolean  "winner",             default: false
  end

  add_index "giveaways_entrants", ["confirmation_token"], name: "index_giveaways_entrants_on_confirmation_token"
  add_index "giveaways_entrants", ["confirmed_email"], name: "index_giveaways_entrants_on_confirmed_email"
  add_index "giveaways_entrants", ["giveaway_id"], name: "index_giveaways_entrants_on_giveaway_id"
  add_index "giveaways_entrants", ["referral_token"], name: "index_giveaways_entrants_on_referral_token"

  create_table "giveaways_giveaways", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "number_of_prizes"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "thank_you_message"
    t.string   "email_subject"
    t.text     "email_message"
    t.string   "email_from"
    t.string   "email_reply_to"
    t.integer  "ballots_per_referral", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "giveaways_admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
