class AddTokenAndSecretTokenToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :token, :string
    add_column :authentications, :secret_token, :string
  end

  def self.down
    remove_column :authentications, :secret_token
    remove_column :authentications, :token
  end
end
