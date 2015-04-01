class CreatePhoneCarriers < ActiveRecord::Migration
  def change
    create_table :phone_carriers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
