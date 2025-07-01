# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_01_061937) do
  create_table "card_sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.string "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "card_id" ], name: "index_card_sessions_on_card_id"
    t.index [ "session_id", "card_id" ], name: "index_card_sessions_on_session_id_and_card_id", unique: true
    t.index [ "session_id" ], name: "index_card_sessions_on_session_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "shape"
    t.string "texture"
    t.string "color"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "game_id", limit: 36, null: false
    t.string "status"
    t.index [ "game_id" ], name: "index_cards_on_game_id"
  end

  create_table "game_sessions", force: :cascade do |t|
    t.string "game_id", null: false
    t.string "session_id"
    t.string "nickname"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_id"
    t.index [ "game_id" ], name: "index_game_sessions_on_game_id"
  end

  create_table "games", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "id" ], name: "index_games_on_id", unique: true
  end

  add_foreign_key "card_sessions", "cards"
  add_foreign_key "cards", "games"
  add_foreign_key "game_sessions", "games"
end
