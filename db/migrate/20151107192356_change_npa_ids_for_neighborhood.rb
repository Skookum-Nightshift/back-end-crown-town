class ChangeNpaIdsForNeighborhood < ActiveRecord::Migration
  def change
    change_column :neighborhoods, :npa_ids, :string
  end
end
