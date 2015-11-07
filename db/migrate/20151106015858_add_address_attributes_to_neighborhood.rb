class AddAddressAttributesToNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :address_line_1, :string
    add_column :neighborhoods, :address_line_2, :string
    add_column :neighborhoods, :zip, :string
    add_column :neighborhoods, :city, :string
    add_column :neighborhoods, :state, :string
  end
end
