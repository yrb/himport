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

ActiveRecord::Schema[7.2].define(version: 2024_08_27_013800) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "hilti_import_id", null: false
    t.string "reference", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "metadata"
    t.string "clarinspect_drawing_id"
    t.string "clarinspect_asset_id"
    t.index ["hilti_import_id"], name: "index_floor_plans_on_hilti_import_id"
    t.index ["reference"], name: "index_floor_plans_on_reference", unique: true
  end

  create_table "hilti_imports", force: :cascade do |t|
    t.string "label"
    t.boolean "processed"
    t.datetime "sent_at"
    t.text "projects"
    t.text "penetrations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "import_project_id", null: false
    t.index ["import_project_id"], name: "index_hilti_imports_on_import_project_id"
  end

  create_table "hilti_projects", force: :cascade do |t|
    t.bigint "hilti_import_id", null: false
    t.string "reference", null: false
    t.string "name"
    t.string "address"
    t.json "products"
    t.json "approvals"
    t.json "floor_plans"
    t.json "fields"
    t.json "configuration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "building"
    t.string "category_id"
    t.string "category_name"
    t.index ["hilti_import_id"], name: "index_hilti_projects_on_hilti_import_id"
    t.index ["reference", "category_id"], name: "index_hilti_projects_on_reference_and_category_id"
  end

  create_table "import_projects", force: :cascade do |t|
    t.string "label"
    t.integer "organisation_id"
    t.json "template"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspection_images", force: :cascade do |t|
    t.bigint "hilti_import_id", null: false
    t.string "reference", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "clarinspect_asset_id"
    t.index ["hilti_import_id"], name: "index_inspection_images_on_hilti_import_id"
    t.index ["reference"], name: "index_inspection_images_on_reference", unique: true
  end

  create_table "test_reports", force: :cascade do |t|
    t.bigint "hilti_import_id", null: false
    t.string "reference", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hilti_import_id"], name: "index_test_reports_on_hilti_import_id"
    t.index ["reference"], name: "index_test_reports_on_reference", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "floor_plans", "hilti_imports"
  add_foreign_key "hilti_imports", "import_projects"
  add_foreign_key "hilti_projects", "hilti_imports"
  add_foreign_key "inspection_images", "hilti_imports"
  add_foreign_key "test_reports", "hilti_imports"
end
