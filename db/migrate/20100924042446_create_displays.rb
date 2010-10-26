class CreateDisplays < ActiveRecord::Migration
  def self.up
    create_table :displays do |t|
      t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 10
      t.string :manufacturer,        :null => false, :limit => 20
      t.string :manufacturerwebsite, :null => false
      t.integer :price,              :null => false
      t.string :googleprice,         :null => false
      t.string :model,               :null => false, :limit => 30
      t.string :contrastratio,       :null => false, :limit => 15
      t.integer :length
      t.integer :width
      t.integer :height
      t.string :resolution,          :null => false, :limit => 15
      t.string :monitortype,         :null => false, :limit => 5
      t.integer :screensize,         :null => false
      t.boolean :widescreen,         :null => false
      t.float :displaycolors
      t.integer :vga,                :null => false
      t.integer :hdmi,               :null => false
      t.integer :svideo,             :null => false
      t.integer :dvi,                :null => false
      t.integer :displayport,        :null => false

      t.timestamps
    end
	execute "alter table displays add constraint fkDisToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table displays drop foreign key fkDisToPart"
    execute "alter table displays drop key fkDisToPart"
    drop_table :displays
  end
end
