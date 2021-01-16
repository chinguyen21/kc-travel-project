class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :event_id
      t.datetime :date
      t.integer :itinerary_id

      t.timestamps
    end
  end
end
