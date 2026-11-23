# frozen_string_literal: true

# Store items take their amperage and kind from their pictures, and the
# pictures are found by name
class RenameStoreItems < ActiveRecord::Migration[8.1]
  NAMES = {
    'Amp Outlet' => '15 Amp Receptacle',
    'Amp Switch' => '10 Amp Rocker Switch',
    'lamp Holder cover' => 'Lamp Holder Cover'
  }.freeze

  def up
    NAMES.each { |old, new| execute update_sql(old, new) }
  end

  def down
    NAMES.each { |old, new| execute update_sql(new, old) }
  end

  private

  def update_sql(from, to)
    "UPDATE store_items SET name = #{quote(to)} WHERE name = #{quote(from)}"
  end
end
