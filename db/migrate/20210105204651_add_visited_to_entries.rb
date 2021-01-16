class AddVisitedToEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :visited, :boolean, :default => false
  end
end
