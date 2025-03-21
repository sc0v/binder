# frozen_string_literal: true
class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :andrewid
      t.string :cardnumber

      t.timestamps
    end
  end
end
