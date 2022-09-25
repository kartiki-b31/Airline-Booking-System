class CreateBaggages < ActiveRecord::Migration[7.0]
  set_primary_key :baggage_id
  def change
    create_table :baggages do |t|
      t.string :baggage_id
      t.integer :weight
      t.integer :baggage_cost

      t.timestamps
    end
    add_index :baggages, :baggage_id, unique: true
  end
end
