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

ActiveRecord::Schema.define(version: 2022_03_12_050838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "battle_histories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "glaring_face_photo_id", null: false
    t.integer "challenger_score", null: false
    t.integer "result", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["glaring_face_photo_id"], name: "index_battle_histories_on_glaring_face_photo_id"
    t.index ["user_id"], name: "index_battle_histories_on_user_id"
  end

  create_table "beats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id", null: false
    t.uuid "glaring_face_photo_id", null: false
    t.index ["glaring_face_photo_id"], name: "index_beats_on_glaring_face_photo_id"
    t.index ["user_id"], name: "index_beats_on_user_id"
  end

  create_table "glaring_face_photos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "image", null: false
    t.integer "face_score", null: false
    t.integer "defense_win_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "main_choiced", default: false, null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_glaring_face_photos_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "offense_win_count", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "battle_histories", "glaring_face_photos"
  add_foreign_key "battle_histories", "users"
  add_foreign_key "beats", "glaring_face_photos"
  add_foreign_key "beats", "users"
  add_foreign_key "glaring_face_photos", "users"
end
