class CreateShowActors < ActiveRecord::Migration[5.1]
  def change
    create_table :show_actors do |t|
      t.string :name
      t.integer :show_id

      t.timestamps
    end
  end
end
