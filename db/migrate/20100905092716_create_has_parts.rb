class CreateHasParts < ActiveRecord::Migration
  def self.up
    create_table :has_parts do |t|
      t.belongs_to :computer, :null => false
      t.belongs_to :part,     :null => false
      t.string :parttype,     :null => false, :limit => 20
	  t.index :computer
	  t.index :parttype
	  t.index :part

      t.timestamps
    end
	execute "alter table has_parts add constraint fkComputer foreign key(computer_id) references computers(id)"
	execute "alter table has_parts add constraint fkPart_Parttype foreign key(part_id) references parts(id)"
  end

  def self.down
    execute "alter table has_parts drop foreign key fkComputer"
    execute "alter table has_parts drop key fkComputer"
	execute "alter table has_parts drop foreign key fkPart_Parttype"
	execute "alter table has_parts drop key fkPart_Parttype"
    drop_table :has_parts
  end
end
