class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name,     :null => false, :limit => 30, :unique => true
      t.string :email,    :null => false, :limit => 50
      t.string :encrypted_password, :limit => 150
      t.string :salt,     :limit => 150
      t.string :ip,       :null => false, :limit => 30

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
