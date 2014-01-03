class DeleteContactListTable < ActiveRecord::Migration
  def change
    drop_table :contact_lists
  end
end
