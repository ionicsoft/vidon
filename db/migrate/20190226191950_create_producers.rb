class CreateProducers < ActiveRecord::Migration[5.1]
  def change
    create_table :producers do |t|
      t.string :company_name
      t.integer :person_id

      t.timestamps
    end
  end
end
