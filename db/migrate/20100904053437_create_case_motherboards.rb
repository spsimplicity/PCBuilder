class CreateCaseMotherboards < ActiveRecord::Migration
  def self.up
    create_table :case_motherboards do |t|
      t.belongs_to :case, :null => false
      t.string :size,     :null => false, :limit => 15
	  t.index :case

      t.timestamps
    end
	execute "alter table case_motherboards add constraint fkToCaseID foreign key(case_id) references cases(id)"
  end

  def self.down
    execute "alter table case_motherboards drop foreign key fkToCaseID"
    execute "alter table case_motherboards drop key fkToCaseID"
    drop_table :case_motherboards
  end
end
