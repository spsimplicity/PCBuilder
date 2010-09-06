class CreateCpuCoolers < ActiveRecord::Migration
  def self.up
    create_table :cpu_coolers do |t|
	  t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 15
      t.string :model,               :null => false, :limit => 30
      t.string :manufacturer,        :null => false, :limit => 20
      t.string :manufacturerwebsite, :null => false
      t.integer :price,              :null => false
      t.string :googleprice,         :null => false
      t.integer :maxmemheight
      t.float :height,               :null => false
      t.float :width,                :null => false
      t.float :length,               :null => false
	  t.index :part

      t.timestamps
    end
	execute "alter table cpu_coolers add constraint fkCpuCoolerIdToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table cpu_coolers drop foreign key fkCpuCoolerIdToPart"
    drop_table :cpu_coolers
  end
end
