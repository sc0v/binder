# frozen_string_literal: true

class CreateNotificationSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :notification_subscriptions do |t|
      t.bigint :participant_id, null: false
      t.string :endpoint, null: false
      t.string :auth, null: false
      t.string :p256dh, null: false
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :notification_subscriptions, :participant_id
    add_index :notification_subscriptions, :endpoint, unique: true
    add_foreign_key :notification_subscriptions, :participants
  end
end
