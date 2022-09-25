class CreateFlights < ActiveRecord::Migration[7.0]
  set_primary_key :flight_id
  def change
    create_table :flights do |t|
      t.string :name
      t.string :flight_id
      t.string :source
      t.string :destination
      t.string :manufacturer
      t.string :class
      t.integer :capacity
      t.string :status
      t.integer :cost

      t.timestamps
    end
    add_index :flights, :flight_id, unique: true
  end
end
