class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :language
      t.integer :number
      t.text :content
      t.integer :volume

      t.timestamps
    end
    add_index :pages, :language
    add_index :pages, :number
    add_index :pages, :volume
    add_index :pages, [:language, :volume], :unique => true
    add_index :pages, [:language, :volume, :number], :unique => true
  end

  def self.down
    drop_table :pages
  end
end
