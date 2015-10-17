class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :pickup_day
      t.integer :npa_id

      t.timestamps null: false
    end
  end
end
