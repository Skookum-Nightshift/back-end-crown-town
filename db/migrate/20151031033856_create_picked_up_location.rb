class CreatePickedUpLocation < ActiveRecord::Migration
  def change
    create_table :picked_up_locations do |t|
      t.integer :pick_up_id
      t.integer :user_id
      t.string :picked_up_neighborhood_id
    end
  end
end
