class CreateCompostItems < ActiveRecord::Migration
  def change
    create_table :compost_items do |t|
      t.string :name
      t.string :disposal_type

      t.timestamps null: false
    end
  end
end
