class CreateIncompatibles < ActiveRecord::Migration
  def self.up
    create_table :incompatibles do |t|
      t.belongs_to :part1, :null => false
      t.string :part1type, :null => false, :limit => 20
      t.belongs_to :part2, :null => false
      t.string :part2type, :null => false, :limit => 20

      t.timestamps
    end
	execute "alter table incompatibles add constraint fkPart1 foreign key(part1_id) references parts(id)"
	execute "alter table incompatibles add constraint fkPart2 foreign key(part2_id) references parts(id)"
  end

  def self.down
    execute "alter table incompatibles drop key fkPart1"
	execute "alter table incompatibles drop key fkPart2"
    drop_table :incompatibles
  end
end
