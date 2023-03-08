# frozen_string_literal: true

class CreateEventLog < ActiveRecord::Migration[4.2]
  def change
    create_table :events, force: :cascade do |t|
      t.boolean  :is_done
      t.integer  :event_type_id, limit: 4
      t.datetime :created_at
      t.text     :description, limit: 65_535
      t.datetime :updated_at
    end

    create_table :event_types do |t|
      t.boolean :display
      t.string :name, limit: 255
    end
  end
end
