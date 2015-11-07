class RemoveAddressFromNeighborhood < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :latitude, :float
    remove_column :neighborhoods, :longitude, :float
    remove_column :neighborhoods, :address_line_1, :string
    remove_column :neighborhoods, :address_line_2, :string
    remove_column :neighborhoods, :city, :string
    remove_column :neighborhoods, :state, :string
    remove_column :neighborhoods, :zip, :string
  end
end
