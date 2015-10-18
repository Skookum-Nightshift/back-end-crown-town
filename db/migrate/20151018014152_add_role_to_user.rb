class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'client', null: false
  end
end
