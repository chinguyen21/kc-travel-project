class RenameUserDestinations < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_destinations, :user_events
    rename_column :user_events, :destination_id, :event_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
