class CreateReadSpeeds < ActiveRecord::Migration
  def self.up
    create_table :read_speeds do |t|
      t.belongs_to :disc_drife, :null => false
      t.string :readtype,       :null => false, :limit => 15
      t.integer :speed,         :null => false
	  t.index :disc_drife

      t.timestamps
    end
	execute "alter table read_speeds add constraint fkRSpeedToDd foreign key(disc_drife_id) references disc_drives(id)"
  end

  def self.down
    execute "alter table read_speeds drop foreign key fkRSpeedToDd"
    drop_table :read_speeds
  end
end
