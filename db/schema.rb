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

ActiveRecord::Schema[8.0].define(version: 2025_03_23_161850) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "banned_at"
    t.string "ban_reason"
    t.bigint "banned_by_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banned_by_id"], name: "index_admin_users_on_banned_by_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "impersonation_password_digest"
    t.string "reset_password_otp"
    t.datetime "reset_password_otp_sent_at"
    t.string "email_otp"
    t.datetime "email_otp_sent_at"
    t.datetime "email_verified_at"
    t.string "phone_otp"
    t.datetime "phone_otp_sent_at"
    t.datetime "phone_verified_at"
    t.datetime "banned_at"
    t.string "ban_reason"
    t.bigint "banned_by_id"
    t.string "locale"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "gender"
    t.datetime "dob"
    t.jsonb "devices", default: {}, null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banned_by_id"], name: "index_users_on_banned_by_id"
    t.index ["devices"], name: "index_users_on_devices", using: :gin
    t.index ["email"], name: "index_users_on_email"
    t.index ["email_otp"], name: "index_users_on_email_otp", unique: true
    t.index ["metadata"], name: "index_users_on_metadata", using: :gin
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["phone_otp"], name: "index_users_on_phone_otp", unique: true
    t.index ["reset_password_otp"], name: "index_users_on_reset_password_otp", unique: true
  end

  add_foreign_key "admin_users", "admin_users", column: "banned_by_id"
  add_foreign_key "users", "admin_users", column: "banned_by_id"
end
