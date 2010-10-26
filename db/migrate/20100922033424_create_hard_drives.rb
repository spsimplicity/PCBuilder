class CreateHardDrives < ActiveRecord::Migration
  def self.up
    create_table :hard_drives do |t|
	  t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :length => 15
      t.string :manufacturer,        :null => false, :length => 20
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
      t.string :model,               :null => false, :length => 30
      t.string :series,              :length => 20
      t.integer :price,              :null => false
      t.string :interface,           :null => false, :length => 10
      t.integer :capacity,           :null => false
      t.integer :rpm,                :null => false
      t.integer :cache
	  t.index :part

      t.timestamps
    end
	execute "alter table hard_drives add constraint fkHddToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table drop foreign key fkHddToPart"
    execute "alter table drop key fkHddToPart"
    drop_table :hard_drives
  end
end
