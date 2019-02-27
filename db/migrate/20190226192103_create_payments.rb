class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :card_name
      t.string :card_num
      t.integer :cvc
      t.date :expiration

      t.timestamps
    end
  end
end
