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

ActiveRecord::Schema[7.1].define(version: 2025_02_24_092530) do
  create_table "movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 160, null: false, comment: "映画のタイトル。邦題・洋題は一旦考えなくてOK"
    t.string "year", limit: 45, comment: "公開年"
    t.text "description", comment: "映画の説明文"
    t.string "image_url", limit: 150, comment: "映画のポスター画像が格納されているURL"
    t.boolean "is_showing", null: false, comment: "上映中かどうか"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_movies_on_name"
  end

  create_table "reservations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "schedule_id", null: false
    t.bigint "sheet_id", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date", "schedule_id", "sheet_id"], name: "index_reservations_on_date_and_schedule_id_and_sheet_id", unique: true
    t.index ["schedule_id"], name: "index_reservations_on_schedule_id"
    t.index ["sheet_id"], name: "index_reservations_on_sheet_id"
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.time "start_time", null: false, comment: "上映開始時刻"
    t.time "end_time", null: false, comment: "上映終了時刻"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "screen_id", null: false
    t.index ["movie_id"], name: "index_schedules_on_movie_id"
    t.index ["screen_id"], name: "index_schedules_on_screen_id"
  end

  create_table "screens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_screens_on_name", unique: true
  end

  create_table "sheets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "column", limit: 1, null: false
    t.string "row", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "screen_id", null: false
    t.index ["screen_id"], name: "index_sheets_on_screen_id"
  end

  add_foreign_key "reservations", "schedules"
  add_foreign_key "reservations", "sheets"
  add_foreign_key "schedules", "movies"
  add_foreign_key "schedules", "screens"
  add_foreign_key "sheets", "screens"
end
