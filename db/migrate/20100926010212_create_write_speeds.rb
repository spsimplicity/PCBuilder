class CreateWriteSpeeds < ActiveRecord::Migration
  def self.up
    create_table :write_speeds do |t|
      t.belongs_to :disc_drife, :null => false
      t.string :writetype,      :null => false, :limit => 15
      t.integer :speed,         :null => false
	  t.index :disc_drife

      t.timestamps
    end
	execute "alter table write_speeds add constraint fkWSpeedToDd foreign key(disc_drife_id) references disc_drives(id)"
  end

  def self.down
    execute "alter table write_speeds drop foreign key fkWSpeedToDd"
    execute "alter table write_speeds drop key fkWSpeedToDd"
    drop_table :write_speeds
  end
end
