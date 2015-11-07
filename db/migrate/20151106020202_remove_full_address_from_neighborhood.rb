class RemoveFullAddressFromNeighborhood < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :full_address, :string
  end
end
