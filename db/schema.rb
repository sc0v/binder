# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead.
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

ActiveRecord::Schema.define(version: 20180320203946) do

  create_table "certification_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certifications", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "participant_id"
    t.integer  "certification_type_id"
  end

  add_index "certifications", ["certification_type_id"], name: "index_certifications_on_certification_type_id"
  add_index "certifications", ["participant_id"], name: "index_certifications_on_participant_id"

  create_table "charge_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "requires_booth_chair_approval"
    t.decimal  "default_amount",                precision: 8, scale: 2
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "charge_type_id"
    t.decimal  "amount",                   precision: 8, scale: 2
    t.text     "description"
    t.integer  "issuing_participant_id"
    t.integer  "receiving_participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "charged_at"
    t.boolean  "is_approved"
    t.integer  "creating_participant_id"
  end

  add_index "charges", ["organization_id"], name: "index_charges_on_organization_id"

  create_table "checkouts", force: :cascade do |t|
    t.integer  "tool_id"
    t.datetime "checked_out_at"
    t.datetime "checked_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participant_id"
    t.integer  "organization_id"
  end

  add_index "checkouts", ["tool_id"], name: "index_checkouts_on_tool_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "documents", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.boolean  "public"
  end

  create_table "event_types", force: :cascade do |t|
    t.boolean "display"
    t.string  "name",    limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.boolean  "is_done"
    t.integer  "event_type_id",  limit: 4
    t.datetime "created_at"
    t.text     "description",    limit: 65535
    t.datetime "updated_at"
    t.integer  "participant_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "judgement_categories", force: :cascade do |t|
    t.integer  "grouping"
    t.string   "name"
    t.integer  "max_value"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "judgements", force: :cascade do |t|
    t.integer  "judgement_category_id"
    t.integer  "value"
    t.integer  "judge_id"
    t.integer  "organization_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "judgements", ["judge_id"], name: "index_judgements_on_judge_id"
  add_index "judgements", ["judgement_category_id"], name: "index_judgements_on_judgement_category_id"
  add_index "judgements", ["organization_id"], name: "index_judgements_on_organization_id"

  create_table "judges", force: :cascade do |t|
    t.string   "name"
    t.integer  "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_booth_chair"
    t.string   "title"
    t.integer  "booth_chair_order"
  end

  add_index "memberships", ["organization_id"], name: "index_memberships_on_organization_id"
  add_index "memberships", ["participant_id"], name: "index_memberships_on_participant_id"

  create_table "organization_aliases", force: :cascade do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_aliases", ["name"], name: "index_organization_aliases_on_name"
  add_index "organization_aliases", ["organization_id"], name: "index_organization_aliases_on_organization_id"

  create_table "organization_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_building"
  end

  create_table "organization_lists", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "andrew_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "organization_status_types", force: :cascade do |t|
    t.string  "name"
    t.boolean "display"
  end

  create_table "organization_statuses", force: :cascade do |t|
    t.integer  "organization_status_type_id"
    t.integer  "organization_id"
    t.integer  "participant_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_statuses", ["organization_id"], name: "index_organization_statuses_on_organization_id"

  create_table "organization_timeline_entries", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "organization_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_type"
  end

  add_index "organization_timeline_entries", ["organization_id"], name: "index_organization_timeline_entries_on_organization_id"

  create_table "organization_timeline_entry_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.integer  "organization_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  add_index "organizations", ["organization_category_id"], name: "index_organizations_on_organization_category_id"

  create_table "participants", force: :cascade do |t|
    t.string   "andrewid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_signed_waiver"
    t.string   "phone_number"
    t.boolean  "has_signed_hardhat_waiver"
    t.integer  "user_id"
    t.string   "cached_name"
    t.string   "cached_surname"
    t.string   "cached_email"
    t.string   "cached_department"
    t.string   "cached_student_class"
    t.datetime "cache_updated"
    t.integer  "phone_carrier_id"
    t.datetime "waiver_start"
  end

  add_index "participants", ["phone_carrier_id"], name: "index_participants_on_phone_carrier_id"

  create_table "phone_carriers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "shift_participants", force: :cascade do |t|
    t.integer  "shift_id"
    t.integer  "participant_id"
    t.datetime "clocked_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shift_participants", ["participant_id"], name: "index_shift_participants_on_participant_id"
  add_index "shift_participants", ["shift_id"], name: "index_shift_participants_on_shift_id"

  create_table "shift_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "required_number_of_participants"
    t.integer  "organization_id"
    t.integer  "shift_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "shifts", ["organization_id"], name: "index_shifts_on_organization_id"

  create_table "store_items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "quantity"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "store_purchases", force: :cascade do |t|
    t.integer  "charge_id"
    t.integer  "store_item_id"
    t.decimal  "price_at_purchase",  precision: 8, scale: 2
    t.integer  "quantity_purchased"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "store_purchases", ["charge_id"], name: "index_store_purchases_on_charge_id"
  add_index "store_purchases", ["store_item_id"], name: "index_store_purchases_on_store_item_id"

  create_table "tasks", force: :cascade do |t|
    t.datetime "due_at"
    t.integer  "completed_by_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_completed"
  end

  create_table "tool_type_certifications", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "tool_type_id"
    t.integer  "certification_type_id"
  end

  add_index "tool_type_certifications", ["certification_type_id"], name: "index_tool_type_certifications_on_certification_type_id"
  add_index "tool_type_certifications", ["tool_type_id"], name: "index_tool_type_certifications_on_tool_type_id"

  create_table "tool_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tool_waitlists", force: :cascade do |t|
    t.integer  "tool_type_id"
    t.datetime "wait_start_time"
    t.integer  "participant_id"
    t.integer  "organization_id"
    t.string   "note"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tool_waitlists", ["tool_type_id"], name: "index_tool_waitlists_on_tool_type_id"

  create_table "tools", force: :cascade do |t|
    t.integer  "barcode"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tool_type_id"
  end

  add_index "tools", ["barcode"], name: "index_tools_on_barcode"
  add_index "tools", ["tool_type_id"], name: "index_tools_on_tool_type_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
