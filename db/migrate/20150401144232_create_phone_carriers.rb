class CreatePhoneCarriers < ActiveRecord::Migration[4.2]
  def change
    create_table :phone_carriers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
