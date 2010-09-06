class CreatePowerSupplies < ActiveRecord::Migration
  def self.up
    create_table :power_supplies do |t|
	  t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 20
      t.string :manufacturer,        :null => false, :limit => 30
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
      t.integer :price,              :null => false
      t.string :model,               :null => false, :limit => 30
      t.string :series,              :null => false, :limit => 30
      t.integer :fansize,            :null => false
      t.integer :mainpower,          :null => false
      t.integer :satapower,          :null => false
      t.boolean :multi_gpu,          :null => false
      t.integer :peripheral,         :null => false
      t.string :energycert,          :limit => 20
      t.string :power_supply_type,   :null => false, :limit => 40
      t.integer :poweroutput,        :null => false
      t.integer :cpu4_4pin,          :null => false
      t.integer :cpu4pin,            :null => false
      t.integer :cpu8pin,            :null => false
      t.integer :gpu8pin,            :null => false
      t.integer :gpu6pin,            :null => false
      t.integer :gpu6_2pin,          :null => false
      t.integer :length,             :null => false
	  t.index :part

      t.timestamps
    end
	execute "alter table power_supplies add constraint fkPowerSupplyIdToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table power_supplies drop foreign key fkPowerSupplyIdToPart"
    drop_table :power_supplies
  end
end
