class CreateShiftTypes < ActiveRecord::Migration
  def change
    create_table :shift_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
