class CreateHardDrives < ActiveRecord::Migration
  def self.up
    create_table :hard_drives do |t|
      t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 15
      t.string :manufacturer,        :null => false, :limit => 30
      t.string :model,               :null => false, :limit => 40
      t.string :series,              :limit => 25
      t.integer :price,              :null => false
      t.string :interface,           :null => false, :limit => 20
      t.integer :capacity,           :null => false
      t.integer :rpm,                :null => false
      t.integer :cache
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
	  t.index :part

      t.timestamps
    end
	execute "alter table hard_drives add constraint fkHddToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table drop foreign key fkHddToPart"
    drop_table :hard_drives
  end
end
