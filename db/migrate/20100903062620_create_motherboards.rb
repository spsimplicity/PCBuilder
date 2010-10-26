class CreateMotherboards < ActiveRecord::Migration
  def self.up
    create_table :motherboards do |t|
	  t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 15
      t.string :manufacturer,        :null => false, :limit => 15
      t.string :model,               :null => false, :limit => 40
      t.integer :price,              :null => false
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
      t.integer :maxmemory,          :null => false
      t.string :memorytype,          :null => false, :limit => 5
	  t.integer :memchannel,         :null => false
      t.integer :pci_ex16,           :null => false
      t.integer :pci_e2,             :null => false
      t.integer :memoryslots,        :null => false
      t.string :size,                :null => false, :limit => 15
      t.integer :cpupowerpin,        :null => false
      t.integer :fsb,                :null => false
      t.string :northbridge,         :null => false, :limit => 25
      t.string :southbridge,         :limit => 25
      t.integer :mainpower,          :null => false
      t.integer :pci_e,              :null => false
      t.integer :pci,                :null => false
      t.boolean :crossfire,          :null => false
	  t.boolean :sli,                :null => false
      t.string :sockettype,          :null => false, :limit => 10
      t.integer :sata3,              :null => false
      t.integer :sata6,              :null => false
      t.integer :ide,                :null => false
	  t.index :part

      t.timestamps
    end
	execute "alter table motherboards add constraint fkMotherboarIdToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table motherboards drop foreign key fkMotherboarIdToPart"
    execute "alter table motherboards drop key fkMotherboarIdToPart"
    drop_table :motherboards
  end
end
