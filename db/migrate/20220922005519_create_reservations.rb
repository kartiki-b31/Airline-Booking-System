class CreateReservations < ActiveRecord::Migration[7.0]
  set_primary_key :res_id
  def change
    create_table :reservations do |t|
      t.integer :passengers
      t.string :res_id
      t.string :ticket_class
      t.string :amenities
      t.integer :total_cost

      t.timestamps
    end
    add_index :reservations, :res_id, unique: true
  end
end
