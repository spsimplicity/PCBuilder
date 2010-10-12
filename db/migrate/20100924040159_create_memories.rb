class CreateMemories < ActiveRecord::Migration
  def self.up
    create_table :memories do |t|
      t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 10
      t.string :manufacturer,        :null => false, :limit => 20
      t.string :manufacturerwebsite, :null => false
      t.integer :price,              :null => false
      t.string :googleprice,         :null => false
      t.string :model,               :null => false, :limit => 30
      t.string :series,              :limit => 30
      t.integer :speed,              :null => false
      t.string :timings,             :null => false, :limit => 15
      t.integer :capacity,           :null => false
      t.integer :multichanneltype,   :null => false
      t.string :memorytype,          :null => false, :limit => 5
      t.integer :pinnumber,          :null => false
      t.integer :dimms,              :null => false
      t.integer :totalcapacity,      :null => false
      t.float :voltage,              :null => false
	  t.index :part

      t.timestamps
    end
	execute "alter table memories add constraint fkMemToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table memories drop foreign key fkMemToPart"
    drop_table :memories
  end
end
