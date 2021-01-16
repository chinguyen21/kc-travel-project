class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :content
      t.integer :user_id
      t.integer :destination_id

      t.timestamps
    end
  end
end
