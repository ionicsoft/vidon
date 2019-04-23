class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :payment_id
      t.text :amount
      t.text :description

      t.timestamps
    end
  end
end
