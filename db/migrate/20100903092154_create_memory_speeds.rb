class CreateMemorySpeeds < ActiveRecord::Migration
  def self.up
    create_table :memory_speeds do |t|
      t.belongs_to :motherboard, :null => false
      t.integer :speed,          :null => false
	  t.index :motherboard

      t.timestamps
    end
	execute "alter table memory_speeds add constraint fkToMoboID foreign key(motherboard_id) references motherboards(id)"
  end

  def self.down
    execute "alter table memory_speeds drop key fkToMoboID"
    drop_table :memory_speeds
  end
end
