class CreateAddress < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :addresses, [:latitude, :longitude]
  end
end
