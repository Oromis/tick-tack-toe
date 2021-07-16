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

ActiveRecord::Schema.define(version: 2021_07_16_094104) do

  create_table "games", force: :cascade do |t|
    t.integer "player_x_id"
    t.integer "player_o_id"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_player_id"
    t.integer "size", default: 3
    t.integer "winner_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.string "symbol", null: false
    t.integer "x", null: false
    t.integer "y", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id", "x", "y"], name: "index_pieces_on_game_id_and_x_and_y", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "games", "users", column: "active_player_id"
  add_foreign_key "games", "users", column: "player_o_id", on_delete: :nullify
  add_foreign_key "games", "users", column: "player_x_id", on_delete: :nullify
  add_foreign_key "games", "users", column: "winner_id"
  add_foreign_key "pieces", "games"
end
