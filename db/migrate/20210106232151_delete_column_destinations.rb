class DeleteColumnDestinations < ActiveRecord::Migration[6.0]
  def change
    remove_column :destinations, :city
    remove_column :destinations, :state
    remove_column :destinations, :country
  end
end
