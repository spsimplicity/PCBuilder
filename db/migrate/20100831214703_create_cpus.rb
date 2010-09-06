class CreateCpus < ActiveRecord::Migration
  def self.up
    create_table :cpus do |t|
	  t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 10
      t.string :model,               :null => false, :limit => 10
      t.string :manufacturer,        :null => false, :limit => 10
      t.string :series,              :limit => 30
      t.integer :price,              :null => false
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
      t.float :frequency,            :null => false
      t.string :sockettype,          :null => false, :limit => 15
      t.float :fsb,                  :null => false
      t.integer :l1cache
      t.integer :l2cache
      t.integer :l3cache
      t.integer :cores,              :null => false
      t.integer :watts,              :null => false
      t.integer :powerpin,           :null => false
      t.integer :maxmemory,          :null => false
      t.integer :memchanneltype,     :null => false
	  t.index :part
	  
      t.timestamps
    end
	execute "alter table cpus add constraint fkCpuIdToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table cpus drop foreign key fkCpuIdToPart"
    drop_table :cpus
  end
end
