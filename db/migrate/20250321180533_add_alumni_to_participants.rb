class AddAlumniToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :alumni, :boolean
  end
end
