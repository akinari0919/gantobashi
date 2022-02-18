ActiveRecord::Schema.define(version: 2022_02_18_035443) do

  enable_extension "plpgsql"

  create_table "glaring_face_photos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "image", null: false
    t.integer "face_score", null: false
    t.integer "defense_win_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "main_choiced", default: false, null: false
    t.index ["user_id"], name: "index_glaring_face_photos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "offense_win_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "glaring_face_photos", "users"
end
