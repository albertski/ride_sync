class CreateDrivers < ActiveRecord::Migration[7.1]
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.references :home_address, null: false, foreign_key: { to_table: :addresses }

      t.timestamps
    end

    add_index :drivers, [:first_name, :last_name, :home_address_id], unique: true
  end
end
