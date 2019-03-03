class ChangeColumnNameForPeople < ActiveRecord::Migration[5.1]
  def change
    rename_column :people, :password, :password_digest
  end
end
