class CreateWeathers < ActiveRecord::Migration[8.0]
  def change
    create_table :weathers do |t|
      t.string :location
      t.datetime :date_time
      t.float :precipitation_chance
      t.integer :precipitation_type
      t.float :lighting_density
      t.float :temperature
      t.integer :severe_weather_idx

      t.timestamps
    end
  end
end
