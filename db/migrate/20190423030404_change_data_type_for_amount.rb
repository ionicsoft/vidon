class ChangeDataTypeForAmount < ActiveRecord::Migration[5.2]
  def change
    def self.up
      change_table :invoices do |t|
        t.change :amount, :text
      end
    end
    def self.down
      change_table :invoices do |t|
        t.change :amount, :text
      end
    end
  end
end
