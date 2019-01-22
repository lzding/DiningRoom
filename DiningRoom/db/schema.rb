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

ActiveRecord::Schema.define(version: 2019_01_22_081434) do

  create_table "attendance_notes", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_id"
    t.datetime "work_date"
    t.integer "status"
    t.datetime "on_duty_time"
    t.datetime "off_duty_time"
    t.datetime "fill_clock_time"
    t.integer "fill_clock_type"
    t.string "remark"
    t.integer "over_times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "fill_clock_mark_time"
    t.index ["fill_clock_type"], name: "index_attendance_notes_on_fill_clock_type"
    t.index ["status"], name: "index_attendance_notes_on_status"
    t.index ["user_id"], name: "index_attendance_notes_on_user_id"
    t.index ["work_date"], name: "index_attendance_notes_on_work_date"
  end

  create_table "menus", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "dinner_date"
    t.integer "dinner_type"
    t.string "dish_one"
    t.string "dish_two"
    t.string "dish_three"
    t.string "soup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dinner_date"], name: "index_menus_on_dinner_date"
    t.index ["dinner_type"], name: "index_menus_on_dinner_type"
  end

  create_table "orders", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_id"
    t.datetime "order_date"
    t.integer "status"
    t.string "pick_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_nr", null: false
    t.index ["order_date"], name: "index_orders_on_order_date"
    t.index ["pick_user_id"], name: "index_orders_on_pick_user_id"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["user_nr"], name: "index_orders_on_user_nr"
  end

  create_table "permission_group_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "permission_id"
    t.bigint "permission_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_group_id"], name: "index_permission_group_items_on_permission_group_id"
    t.index ["permission_id"], name: "index_permission_group_items_on_permission_id"
  end

  create_table "permission_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_permission_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_id"
    t.bigint "permission_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_group_id"], name: "index_user_permission_groups_on_permission_group_id"
    t.index ["user_id"], name: "index_user_permission_groups_on_user_id"
  end

  create_table "users", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "nr", null: false
    t.string "email"
    t.integer "role_id", default: 100, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_users_on_id"
    t.index ["nr"], name: "index_users_on_nr", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "permission_group_items", "permission_groups"
  add_foreign_key "permission_group_items", "permissions"
end
