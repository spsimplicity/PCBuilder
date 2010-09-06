class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.string :parttype, :null => false, :limit => 20
	  t.index :parttype

      t.timestamps
    end	
  end

  def self.down
    drop_table :parts
  end
end
