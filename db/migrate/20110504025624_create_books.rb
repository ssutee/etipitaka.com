class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :language
      t.integer :category
      t.integer :volume
      t.string :title

      t.timestamps
    end
    add_index :books, [:language, :volume], :unique => true
  end

  def self.down
    drop_table :books
  end
end
