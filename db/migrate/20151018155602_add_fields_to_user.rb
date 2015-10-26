class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bucket_location, :string, default: "FrontDoor", null: false
    add_column :users, :can_pickup, :boolean, default: true, null: false 
  end
end
