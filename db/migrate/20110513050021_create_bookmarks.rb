class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.text :note
      t.integer :user_id
      t.integer :page_id

      t.timestamps

    end

    add_index :bookmarks, :user_id
  end

  def self.down
    drop_table :bookmarks
  end
end
