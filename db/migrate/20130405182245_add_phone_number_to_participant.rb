class AddPhoneNumberToParticipant < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :phone_number, :string
  end
end
