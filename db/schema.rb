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

ActiveRecord::Schema.define(version: 2019_06_01_095242) do

  create_table "exercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "en_name"
    t.string "ja_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["en_name"], name: "index_exercises_on_en_name", unique: true
    t.index ["ja_name"], name: "index_exercises_on_ja_name", unique: true
  end

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "training_record_id", null: false
    t.integer "weight", null: false
    t.integer "rep", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_record_id"], name: "index_menus_on_training_record_id"
  end

  create_table "training_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "exercise_id", null: false
    t.string "part", null: false
    t.integer "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_training_records_on_user_id"
  end

  create_table "user_bodies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "weight"
    t.integer "height"
    t.string "gender"
    t.integer "birth_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_bodies_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "avator"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menus", "training_records"
  add_foreign_key "training_records", "users"
  add_foreign_key "user_bodies", "users"
end
