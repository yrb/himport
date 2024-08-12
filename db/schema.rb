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

ActiveRecord::Schema[7.2].define(version: 2024_08_12_003355) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "floor_plans", force: :cascade do |t|
    t.integer "hilti_import_id", null: false
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hilti_import_id"], name: "index_floor_plans_on_hilti_import_id"
  end

  create_table "hilti_imports", force: :cascade do |t|
    t.string "label"
    t.boolean "processed"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "project_data"
    t.string "project_name"
  end

  create_table "inspection_images", force: :cascade do |t|
    t.integer "hilti_import_id", null: false
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hilti_import_id"], name: "index_inspection_images_on_hilti_import_id"
  end

  create_table "list_reports", force: :cascade do |t|
    t.integer "hilti_import_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hilti_import_id"], name: "index_list_reports_on_hilti_import_id"
  end

  create_table "pdf_reports", force: :cascade do |t|
    t.integer "hilti_import_id", null: false
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hilti_import_id"], name: "index_pdf_reports_on_hilti_import_id"
  end

  create_table "test_reports", force: :cascade do |t|
    t.integer "hilti_import_id", null: false
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hilti_import_id"], name: "index_test_reports_on_hilti_import_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "floor_plans", "hilti_imports"
  add_foreign_key "inspection_images", "hilti_imports"
  add_foreign_key "list_reports", "hilti_imports"
  add_foreign_key "pdf_reports", "hilti_imports"
  add_foreign_key "test_reports", "hilti_imports"
end
