class CreateDiscDrives < ActiveRecord::Migration
  def self.up
    create_table :disc_drives do |t|
      t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 10
      t.string :manufacturer,        :null => false, :limit => 30
      t.string :manufacturerwebsite, :null => false
      t.integer :price,              :null => false
      t.string :googleprice,         :null => false
      t.string :model,               :null => false, :limit => 20
      t.string :interface,           :null => false, :limit => 10
      t.integer :cache
      t.string :drivetype,           :null => false, :limit => 15
	  t.index :part

      t.timestamps
    end
	execute "alter table disc_drives add constraint fkDdToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table disc_drives drop foreign key fkDdToPart"
    drop_table :disc_drives
  end
end
