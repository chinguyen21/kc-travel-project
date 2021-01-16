class AddCityIdToDestinations < ActiveRecord::Migration[6.0]
  def change
    add_column :destinations, :city_id, :integer
  end
end
