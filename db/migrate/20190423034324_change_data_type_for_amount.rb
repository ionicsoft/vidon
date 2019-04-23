class ChangeDataTypeForAmount < ActiveRecord::Migration[5.2]
  def change
   change_table :invoices do |t|
      t.change :amount, :decimal
    end
  end
end
