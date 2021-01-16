class AddArchivedToItineraries < ActiveRecord::Migration[6.0]
  def change
    add_column :itineraries, :archived, :boolean, :default => false
  end
end
