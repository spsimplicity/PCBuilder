class CreateCases < ActiveRecord::Migration
  def self.up
    create_table :cases do |t|
	  t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 5
      t.string :manufacturer,        :null => false, :limit => 20
      t.integer :price,              :null => false
      t.string :model,               :null => false, :limit => 30
      t.string :series,              :limit => 30
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
      t.integer :totalbays,          :null => false
      t.integer :hddbays,            :null => false
      t.integer :conversionbays,     :null => false
      t.integer :ssdbays,            :null => false
      t.integer :expansionslots,     :null => false
      t.integer :discbays,           :null => false
      t.string :casetype,            :null => false, :limit => 25
      t.integer :length,             :null => false
      t.integer :width,              :null => false
      t.integer :height,             :null => false
	  t.index :part
	  
      t.timestamps
    end
	execute "alter table cases add constraint fkCaseIdToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table cases drop foreign key fkCaseIdToPart"
    drop_table :cases
  end
end
