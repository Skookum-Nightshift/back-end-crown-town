class AddWeightToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_compost_weight, :integer
    add_column :users, :total_compost_weight, :integer
  end
end
