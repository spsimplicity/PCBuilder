class Computer < ActiveRecord::Base
  
  #Only name attribute can be changed with params hash
  attr_accessible :name
  #Name validations
  validates_length_of :name, :maximum => 50
  #Motherboard_id, cpu_id, cpu_cooler_id, power_supply_id, case_id, and user_id validations
  validates_presence_of :motherboard_id, :cpu_id, :case_id, :cpu_cooler_id, :power_supply_id, :user_id
  validates_numericality_of :motherboard_id, :cpu_id, :case_id,
      :cpu_cooler_id, :power_supply_id, :user_id, :only_integer => true, :greater_than => 0
  validates_each :motherboard_id, :cpu_id, :case_id, :cpu_cooler_id, :power_supply_id, :user_id do |record, attr, value|
      begin
	      find(value)
      rescue => msg
	      record.errors.add(attr, msg)
	  end
  end
  #Foreign key validations
  belongs_to :motherboard, :autosave => true
  belongs_to :cpu, :autosave => true
  belongs_to :cpu_cooler, :autosave => true
  belongs_to :power_supply, :autosave => true
  belongs_to :case, :autosave => true
  belongs_to :user, :autosave => true
end
