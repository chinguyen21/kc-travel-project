class AddPictureLinkToDestinations < ActiveRecord::Migration[6.0]
  def change
    add_column :destinations, :picture_link, :string
  end
end
