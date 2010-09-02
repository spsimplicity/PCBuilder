class CreateComputers < ActiveRecord::Migration
  def self.up
    create_table :computers do |t|
      t.string :name,             :null => false, :limit => 50, :default => 'Custom Built Computer'
      t.belongs_to :motherboard,  :null => false
      t.belongs_to :cpu,          :null => false
      t.belongs_to :cpu_cooler,   :null => false
      t.belongs_to :power_supply, :null => false
      t.belongs_to :case,         :null => false
      t.belongs_to :user,         :null => false
      t.index :cpu
	  t.index :cpu_cooler
	  t.index :power_supply
	  t.index :case
	  t.index :user
      t.timestamps
    end
	#execute "alter table computers add constraint fkToCpuID foreign key(cpuid) references cpus(id)"
	#execute "alter table computers add constraint fkToCpuFanID foreign key(cpucoolerid) references cpufans(id)"
	#execute "alter table computers add constraint fkToPsuID foreign key(powersupplyid) references powersupplies(id)"
	#execute "alter table computers add constraint fkToCaseID foreign key(caseid) references cases(id)"
	#execute "alter table computers add constraint fkToMoboID foreign key(motherboardid) references motherboards(id)"
	execute "alter table computers add constraint fkToUserID foreign key(user_id) references users(id)"
  end

  def self.down
    drop_table :computers
  end
end
