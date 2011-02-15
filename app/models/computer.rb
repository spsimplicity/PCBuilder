class Computer < ActiveRecord::Base
  
	#Only name attribute can be changed with params hash
	attr_accessible :name
	#Name validations
	validates_length_of :name, :maximum => 50
	#Motherboard_id, cpu_id, cpu_cooler_id, power_supply_id, case_id, and user_id validations
	validates_numericality_of :motherboard_id, :cpu_id, :case_id,
	    :cpu_cooler_id, :power_supply_id, :user_id, :only_integer => true, :greater_than => 0
	validates_each :motherboard_id do |record, attr, value|
	    if value != nil
	        record.errors.add("Motherboard does not exist") if Motherboard.find_by_id(value) == nil
		end
	end
	validates_each :cpu_id do |record, attr, value|
	    if value != nil
	        record.errors.add("CPU does not exist") if Cpu.find_by_id(value) == nil
		end
	end
	validates_each :case_id do |record, attr, value|
	    if value != nil
	        record.errors.add("Case does not exist") if Case.find_by_id(value) == nil
		end
	end
	validates_each :cpu_cooler_id do |record, attr, value|
	    if value != nil
	        record.errors.add("CPU Cooler does not exist") if CpuCooler.find_by_id(value) == nil
		end
	end
	validates_each :power_supply_id do |record, attr, value|
	    if value != nil
	        record.errors.add("Power Supply does not exist") if PowerSupply.find_by_id(value) == nil
		end
	end
	validates_each :user_id do |record, attr, value|
	    if value != nil
	        record.errors.add("User does not exist") if User.find_by_id(value) == nil
		end
	end
	
	#Foreign key validations
	belongs_to :motherboard, :autosave => true
	belongs_to :cpu, :autosave => true
	belongs_to :cpu_cooler, :autosave => true
	belongs_to :power_supply, :autosave => true
	belongs_to :case, :autosave => true
	belongs_to :user, :autosave => true
	has_many :has_parts, :foreign_key => "computer_id", :autosave => true
	
	def getIds
	    ids = [:motherboard_id, :cpu_id, :case_id, :cpu_cooler_id, :power_supply_id]
	end
end
