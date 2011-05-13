class AddItemNumberToBookmarks < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :item_number, :integer
  end

  def self.down
    remove_column :bookmarks, :item_number
  end
end
