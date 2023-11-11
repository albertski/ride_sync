class CreateRides < ActiveRecord::Migration[7.1]
  def change
    create_table :rides do |t|
      t.references :start_address, null: false, foreign_key: { to_table: :addresses }
      t.references :destination_address, null: false, foreign_key: { to_table: :addresses }

      t.timestamps
    end

    add_index :rides, [:start_address_id, :destination_address_id], unique: true
  end
end
