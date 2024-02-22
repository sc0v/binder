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

ActiveRecord::Schema[7.0].define(version: 2024_02_09_173331) do
  create_table "certification_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "certifications", force: :cascade do |t|
    t.integer "participant_id"
    t.integer "certification_type_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["certification_type_id"], name: "index_certifications_on_certification_type_id"
    t.index ["participant_id"], name: "index_certifications_on_participant_id"
  end

  create_table "charge_types", force: :cascade do |t|
    t.string "name"
    t.boolean "requires_booth_chair_approval"
    t.decimal "default_amount", precision: 8, scale: 2
    t.text "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "charges", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "charge_type_id"
    t.decimal "amount", precision: 8, scale: 2
    t.text "description"
    t.integer "issuing_participant_id"
    t.integer "receiving_participant_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.datetime "charged_at", precision: nil
    t.boolean "is_approved"
    t.integer "creating_participant_id"
    t.index ["organization_id"], name: "index_charges_on_organization_id"
  end

  create_table "checkouts", force: :cascade do |t|
    t.integer "tool_id"
    t.datetime "checked_out_at", precision: nil
    t.datetime "checked_in_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "participant_id"
    t.integer "organization_id"
    t.index ["tool_id"], name: "index_checkouts_on_tool_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at", precision: nil
    t.datetime "locked_at", precision: nil
    t.datetime "failed_at", precision: nil
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "event_types", force: :cascade do |t|
    t.boolean "display"
    t.string "name", limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.boolean "is_done"
    t.integer "event_type_id", limit: 4
    t.datetime "created_at", precision: nil
    t.text "description", limit: 65535
    t.datetime "updated_at", precision: nil
    t.integer "participant_id"
  end

  create_table "faq", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "organization_category_id"
    t.index ["organization_category_id"], name: "index_faq_on_organization_category_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "participant_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "is_booth_chair"
    t.string "title"
    t.integer "booth_chair_order"
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["participant_id"], name: "index_memberships_on_participant_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.integer "organization_id"
    t.boolean "hidden"
    t.string "title"
    t.string "value"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_notes_on_organization_id"
    t.index ["participant_id"], name: "index_notes_on_participant_id"
  end

  create_table "organization_aliases", force: :cascade do |t|
    t.string "name"
    t.integer "organization_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_organization_aliases_on_name"
    t.index ["organization_id"], name: "index_organization_aliases_on_organization_id"
  end

  create_table "organization_build_statuses", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.string "status_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_build_statuses_on_organization_id"
  end

  create_table "organization_build_steps", force: :cascade do |t|
    t.string "title"
    t.text "requirements"
    t.integer "step"
    t.boolean "completed"
    t.integer "organization_build_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_build_status_id"], name: "index_organization_build_steps_on_organization_build_status_id"
  end

  create_table "organization_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "building"
    t.string "lookup_key"
    t.index ["name"], name: "index_organization_categories_on_name", unique: true
  end

  create_table "organization_status_types", force: :cascade do |t|
    t.string "name"
    t.boolean "display"
  end

  create_table "organization_statuses", force: :cascade do |t|
    t.integer "organization_status_type_id"
    t.integer "organization_id"
    t.integer "participant_id"
    t.string "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["organization_id"], name: "index_organization_statuses_on_organization_id"
  end

  create_table "organization_timeline_entries", force: :cascade do |t|
    t.datetime "started_at", precision: nil
    t.datetime "ended_at", precision: nil
    t.integer "organization_id"
    t.text "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "entry_type"
    t.index ["organization_id"], name: "index_organization_timeline_entries_on_organization_id"
  end

  create_table "organization_timeline_entry_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.integer "organization_category_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "short_name"
    t.index ["organization_category_id"], name: "index_organizations_on_organization_category_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "eppn"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "signed_waiver"
    t.string "phone_number"
    t.string "cached_name"
    t.string "cached_surname"
    t.string "cached_email"
    t.string "cached_department"
    t.string "cached_student_class"
    t.datetime "cache_updated", precision: nil
    t.boolean "admin"
    t.boolean "watched_safety_video"
    t.index ["admin"], name: "index_participants_on_admin"
  end

  create_table "shift_participants", force: :cascade do |t|
    t.integer "shift_id"
    t.integer "participant_id"
    t.datetime "clocked_in_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["participant_id"], name: "index_shift_participants_on_participant_id"
    t.index ["shift_id"], name: "index_shift_participants_on_shift_id"
  end

  create_table "shift_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "short_name"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "starts_at", precision: nil
    t.datetime "ends_at", precision: nil
    t.integer "required_number_of_participants"
    t.integer "organization_id"
    t.integer "shift_type_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "description"
    t.index ["organization_id"], name: "index_shifts_on_organization_id"
  end

  create_table "store_items", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.integer "quantity"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "store_purchases", force: :cascade do |t|
    t.integer "charge_id"
    t.integer "store_item_id"
    t.decimal "price_at_purchase", precision: 8, scale: 2
    t.integer "quantity_purchased"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["charge_id"], name: "index_store_purchases_on_charge_id"
    t.index ["store_item_id"], name: "index_store_purchases_on_store_item_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "due_at", precision: nil
    t.integer "completed_by_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "is_completed"
  end

  create_table "tool_type_certifications", force: :cascade do |t|
    t.integer "tool_type_id"
    t.integer "certification_type_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["certification_type_id"], name: "index_tool_type_certifications_on_certification_type_id"
    t.index ["tool_type_id"], name: "index_tool_type_certifications_on_tool_type_id"
  end

  create_table "tool_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "tools", force: :cascade do |t|
    t.integer "barcode"
    t.text "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "tool_type_id"
    t.boolean "active"
    t.index ["barcode"], name: "index_tools_on_barcode"
    t.index ["tool_type_id"], name: "index_tools_on_tool_type_id"
  end

  add_foreign_key "certifications", "certification_types"
  add_foreign_key "certifications", "participants"
  add_foreign_key "faq", "organization_categories"
  add_foreign_key "notes", "organizations"
  add_foreign_key "notes", "participants"
  add_foreign_key "organization_build_statuses", "organizations"
  add_foreign_key "organization_build_steps", "organization_build_statuses"
  add_foreign_key "store_purchases", "charges"
  add_foreign_key "store_purchases", "store_items"
  add_foreign_key "tool_type_certifications", "certification_types"
  add_foreign_key "tool_type_certifications", "tool_types"
  add_foreign_key "tools", "tool_types"
end
