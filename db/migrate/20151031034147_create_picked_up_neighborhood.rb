class CreatePickedUpNeighborhood < ActiveRecord::Migration
  def change
    create_table :picked_up_neighborhoods do |t|
      t.string :picked_up_date
      t.integer :neighborhood_id
    end
  end
end
