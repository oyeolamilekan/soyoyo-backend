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

ActiveRecord::Schema[7.0].define(version: 2023_06_28_074103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "private_key"
    t.text "public_key"
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_api_keys_on_business_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "title"
    t.text "slug"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "payment_pages", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount", default: "0.0"
    t.integer "status", default: 0
    t.integer "currency", default: 0
    t.index ["business_id"], name: "index_payment_pages_on_business_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "title"
    t.text "name"
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "public_key"
    t.index ["business_id"], name: "index_providers_on_business_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.text "amount"
    t.bigint "payment_page_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_page_id"], name: "index_transactions_on_payment_page_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
  end

  add_foreign_key "api_keys", "businesses"
  add_foreign_key "businesses", "users"
  add_foreign_key "payment_pages", "businesses"
  add_foreign_key "providers", "businesses"
  add_foreign_key "transactions", "payment_pages"
end
