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

ActiveRecord::Schema[7.0].define(version: 2023_08_22_142811) do
  create_table "deliverables", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "project_id", null: false
    t.datetime "due_at"
    t.integer "status", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.json "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_deliverables_on_id", unique: true
  end

  create_table "projects", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_projects_on_id", unique: true
    t.index ["name", "user_id"], name: "index_projects_on_name_and_user_id", unique: true
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "deliverables", "projects", on_delete: :cascade
  add_foreign_key "projects", "users", on_delete: :cascade
end
