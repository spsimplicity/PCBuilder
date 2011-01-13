class CreateGraphicsCards < ActiveRecord::Migration
  def self.up
    create_table :graphics_cards do |t|
      t.belongs_to :part,            :null => false
      t.string :parttype,            :null => false, :limit => 15
      t.string :manufacturer,        :null => false, :limit => 20
      t.string :chipmanufacturer,    :null => false, :limit => 10
      t.integer :price,              :null => false
      t.string :model,               :null => false, :limit => 50
      t.string :series,              :limit => 30
      t.integer :coreclock,          :null => false
      t.integer :shaderclock
      t.integer :memoryclock,        :null => false
      t.integer :memorysize,         :null => false
      t.string :memorytype,          :null => false, :limit => 5
      t.integer :directx,            :null => false
      t.string :width,               :null => false, :limit => 10
      t.integer :length,             :null => false
      t.string :interface,           :null => false, :limit => 15
      t.string :gpu,                 :null => false, :limit => 10
      t.integer :multigpusupport,    :null => false
	  t.string :maxresolution,       :null => false, :limit => 10
      t.integer :hdmi,               :null => false
      t.integer :dvi,                :null => false
      t.integer :displayport,        :null => false
      t.integer :vga,                :null => false
      t.integer :svideo,             :null => false
      t.integer :minpower,           :null => false
      t.integer :multigpupower
      t.integer :power6pin,          :null => false
      t.integer :power8pin,          :null => false
      t.string :manufacturerwebsite, :null => false
      t.string :googleprice,         :null => false
	  t.index :part

      t.timestamps
    end
	execute "alter table graphics_cards add constraint fkGcToPart foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table graphics_cards drop key fkGcToPart"
    drop_table :graphics_cards
  end
end
