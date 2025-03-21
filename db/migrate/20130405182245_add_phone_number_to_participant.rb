# frozen_string_literal: true
class AddPhoneNumberToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :phone_number, :string
  end
end
