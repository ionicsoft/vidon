class AddPolymorphicIndeces < ActiveRecord::Migration[5.1]
  def change
    add_index :videos, [:content_id, :content_type]
    add_index :people, [:user_id, :user_type]
  end
end