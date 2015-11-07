class AddNameToNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :name, :string
    rename_column :neighborhoods, :npa_id, :npa_ids
  end
end
