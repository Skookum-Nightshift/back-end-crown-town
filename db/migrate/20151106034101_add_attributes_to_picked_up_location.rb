class AddAttributesToPickedUpLocation < ActiveRecord::Migration
  def change
    add_column :picked_up_locations, :picked_up_date, :string
    add_column :picked_up_locations, :neighborhood_id, :integer
  end
end
