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

ActiveRecord::Schema[8.1].define(version: 2026_03_25_010002) do
  create_table "action_push_native_devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "owner_id"
    t.string "owner_type"
    t.string "platform", null: false
    t.string "token", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_action_push_native_devices_on_owner"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "brewery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["brewery_id"], name: "index_bookmarks_on_brewery_id"
    t.index ["user_id", "brewery_id"], name: "index_bookmarks_on_user_id_and_brewery_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "breweries", force: :cascade do |t|
    t.string "brewery_type"
    t.string "city", default: "Portland"
    t.datetime "created_at", null: false
    t.boolean "dog_friendly"
    t.text "events"
    t.string "food"
    t.text "happy_hour"
    t.text "hours"
    t.boolean "kid_friendly"
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.string "name", null: false
    t.integer "neighborhood_id"
    t.string "open_brewery_db_id"
    t.boolean "outdoor_seating"
    t.string "phone"
    t.string "photo_attribution"
    t.string "postal_code"
    t.string "state", default: "Oregon"
    t.string "street"
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.boolean "wifi"
    t.index ["neighborhood_id"], name: "index_breweries_on_neighborhood_id"
    t.index ["open_brewery_db_id"], name: "index_breweries_on_open_brewery_db_id", unique: true
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "position", default: 0
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_neighborhoods_on_name", unique: true
  end

  create_table "ruby_native_purchase_intents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "customer_id", null: false
    t.string "environment"
    t.string "product_id"
    t.string "status", default: "pending", null: false
    t.string "success_path"
    t.datetime "updated_at", null: false
    t.string "uuid", null: false
    t.index ["customer_id"], name: "index_ruby_native_purchase_intents_on_customer_id"
    t.index ["uuid"], name: "index_ruby_native_purchase_intents_on_uuid", unique: true
  end

  create_table "stamps", force: :cascade do |t|
    t.integer "brewery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "stamped_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["brewery_id"], name: "index_stamps_on_brewery_id"
    t.index ["user_id", "brewery_id"], name: "index_stamps_on_user_id_and_brewery_id", unique: true
    t.index ["user_id"], name: "index_stamps_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.string "original_transaction_id"
    t.string "product_id"
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["original_transaction_id"], name: "index_subscriptions_on_original_transaction_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "apple_refresh_token"
    t.string "apple_uid"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["apple_uid"], name: "index_users_on_apple_uid", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "breweries"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "breweries", "neighborhoods"
  add_foreign_key "stamps", "breweries"
  add_foreign_key "stamps", "users"
  add_foreign_key "subscriptions", "users"
end
