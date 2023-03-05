class DeleteContactListTable < ActiveRecord::Migration[4.2]
  def change
    drop_table :contact_lists
  end
end
