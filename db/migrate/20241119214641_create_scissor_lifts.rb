class CreateScissorLifts < ActiveRecord::Migration[7.0]
  def change
    create_table :scissor_lifts do |t|
      t.string :name

      t.timestamps
    end
  end
end
