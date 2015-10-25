class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :address
      t.string :city
      t.integer :zipcode
      t.text :state

      t.timestamps null: false
    end
  end
end
