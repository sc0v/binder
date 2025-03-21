# frozen_string_literal: true
class DeleteContactListTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :contact_lists
  end
end
