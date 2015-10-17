class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :message
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
