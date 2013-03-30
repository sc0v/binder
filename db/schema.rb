# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130330003207) do

  create_table "memberships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "participant_id"
    t.boolean  "is_chair"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "memberships", ["organization_id"], :name => "index_memberships_on_organization_id"
  add_index "memberships", ["participant_id"], :name => "index_memberships_on_participant_id"

  create_table "organization_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "organization_category_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "organizations", ["organization_category_id"], :name => "index_organizations_on_organization_category_id"

  create_table "participants", :force => true do |t|
    t.string   "andrewid"
    t.string   "cardnumber"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tools", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "barcode"
    t.text     "description"
    t.integer  "tool_type_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "tools", ["barcode"], :name => "index_tools_on_barcode"

end
