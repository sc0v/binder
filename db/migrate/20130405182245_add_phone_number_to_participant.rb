class AddPhoneNumberToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :phone_number, :string
  end
end
