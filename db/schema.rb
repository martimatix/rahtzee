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

ActiveRecord::Schema.define(version: 20150206234120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "total_score"
    t.boolean  "filled",            default: false
    t.integer  "ones"
    t.integer  "twos"
    t.integer  "threes"
    t.integer  "fours"
    t.integer  "fives"
    t.integer  "sixes"
    t.integer  "raw_upper"
    t.integer  "bonus_upper_score"
    t.integer  "upper_score"
    t.integer  "three_of_a_kind"
    t.integer  "four_of_a_kind"
    t.integer  "full_house"
    t.integer  "small_straight"
    t.integer  "large_straight"
    t.integer  "yahtzee"
    t.integer  "lower_score"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turns", force: :cascade do |t|
    t.integer  "dice_1"
    t.integer  "dice_2"
    t.integer  "dice_3"
    t.integer  "dice_4"
    t.integer  "dice_5"
    t.integer  "roll_counter", default: 1
    t.integer  "game_id"
    t.boolean  "turn_over",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
