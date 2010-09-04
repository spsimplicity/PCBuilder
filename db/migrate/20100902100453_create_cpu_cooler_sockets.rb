class CreateCpuCoolerSockets < ActiveRecord::Migration
  def self.up
    create_table :cpu_cooler_sockets do |t|
      t.belongs_to :cpu_cooler, :null => false
      t.string :sockettype,     :null => false, :limit => 10
      t.index :cpu_cooler
	  
      t.timestamps
    end
	execute "alter table cpu_cooler_sockets add constraint fkToCpuCoolerID foreign key(cpu_cooler_id) references cpu_coolers(id)"
  end

  def self.down
    execute "alter table cpu_cooler_sockets drop foreign key fkToCpuCoolerID"
    drop_table :cpu_cooler_sockets
  end
end
