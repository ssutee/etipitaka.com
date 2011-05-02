class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.boolean :begin
      t.integer :number
      t.integer :section
      t.integer :page_id

      t.timestamps
    end
    add_index :items, :page_id
    add_index :items, :number
    add_index :items, [:page_id, :number]
    add_index :items, [:page_id, :number, :begin]
    add_index :items, [:page_id, :number, :section]
    add_index :items, [:page_id, :number, :section, :begin]
  end

  def self.down
    drop_table :items
  end
end
