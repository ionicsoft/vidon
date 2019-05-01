class ChangePrecisionOfInvoiceAmount < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :amount, :decimal, precision: 5, scale: 2
  end
end
