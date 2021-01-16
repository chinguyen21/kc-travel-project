class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :price
      t.integer :destination_id

      t.timestamps
    end
  end
end
