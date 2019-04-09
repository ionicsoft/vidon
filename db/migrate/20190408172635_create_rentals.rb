class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :customer, foreign_key: true, index: true
      t.references :movie, foreign_key: true, index: true
      t.datetime :expiration, index: true

      t.timestamps
    end
  end
end
