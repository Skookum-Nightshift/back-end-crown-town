class AddFullAddressToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :full_address, :string
  end
end
