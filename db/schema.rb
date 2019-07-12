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

ActiveRecord::Schema.define(version: 2019_07_09_110434) do

  create_table "devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.string "invnum"
    t.string "serial"
    t.datetime "dateprod"
    t.string "proc"
    t.string "ram"
    t.string "place"
    t.string "mark"
    t.boolean "cancellation"
    t.bigint "type_id"
    t.bigint "filial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "iswork"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean "repair"
    t.string "actimage_file_name"
    t.string "actimage_content_type"
    t.integer "actimage_file_size"
    t.datetime "actimage_updated_at"
    t.boolean "clearact"
    t.string "type"
    t.index ["filial_id"], name: "index_devices_on_filial_id"
    t.index ["type_id"], name: "index_devices_on_type_id"
  end

  create_table "filials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "num"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "mark"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_histories_on_device_id"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "FIO"
    t.bigint "filial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filial_id"], name: "index_people_on_filial_id"
  end

  create_table "types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.integer "right", default: 0
    t.bigint "filial_id"
    t.index ["filial_id"], name: "index_users_on_filial_id"
  end

  add_foreign_key "devices", "filials"
  add_foreign_key "devices", "types"
  add_foreign_key "histories", "devices"
  add_foreign_key "people", "filials"
  add_foreign_key "users", "filials"
end
