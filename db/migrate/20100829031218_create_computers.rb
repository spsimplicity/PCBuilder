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
	execute "alter table computers add constraint fkToCpuFromCompID foreign key(cpu_id) references cpus(id)"
	execute "alter table computers add constraint fkToCpuCoolerFromCompID foreign key(cpu_cooler_id) references cpu_coolers(id)"
	execute "alter table computers add constraint fkToPsuFromCompID foreign key(power_supply_id) references power_supplies(id)"
	execute "alter table computers add constraint fkToCaseFromCompID foreign key(case_id) references cases(id)"
	execute "alter table computers add constraint fkToMoboFromCompID foreign key(motherboard_id) references motherboards(id)"
	execute "alter table computers add constraint fkToUserFromCompID foreign key(user_id) references users(id)"
  end

  def self.down
    execute "alter table computers drop foreign key fkToCpuFromCompID"
	execute "alter table computers drop foreign key fkToCpuCoolerFromCompID"
	execute "alter table computers drop foreign key fkToMoboFromCompID"
	execute "alter table computers drop foreign key fkToUserFromCompID"
	execute "alter table computers drop foreign key fkToPsuFromCompID"
	execute "alter table computers drop foreign key fkToCaseFromCompID"
    drop_table :computers
  end
end
