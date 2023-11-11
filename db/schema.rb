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

ActiveRecord::Schema[7.1].define(version: 2023_11_11_005442) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address1", "address2", "city", "state", "zip_code", "country", "latitude", "longitude"], name: "idx_on_address1_address2_city_state_zip_code_countr_4c18074139", unique: true
    t.index ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "home_address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name", "home_address_id"], name: "index_drivers_on_first_name_and_last_name_and_home_address_id", unique: true
    t.index ["home_address_id"], name: "index_drivers_on_home_address_id"
  end

  create_table "rides", force: :cascade do |t|
    t.bigint "start_address_id", null: false
    t.bigint "destination_address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_address_id"], name: "index_rides_on_destination_address_id"
    t.index ["start_address_id", "destination_address_id"], name: "index_rides_on_start_address_id_and_destination_address_id", unique: true
    t.index ["start_address_id"], name: "index_rides_on_start_address_id"
  end

  add_foreign_key "drivers", "addresses", column: "home_address_id"
  add_foreign_key "rides", "addresses", column: "destination_address_id"
  add_foreign_key "rides", "addresses", column: "start_address_id"
end
