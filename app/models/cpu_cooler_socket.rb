class CpuCoolerSocket < ActiveRecord::Base
  
    #No attributes are accessible for mass assignment
    attr_accessible
	#Cpu_cooler_id validations
	validates_presence_of :cpu_cooler_id
	validates_numericality_of :cpu_cooler_id, :greater_than => 0
	validates_each :cpu_cooler_id do |record, attr, value|
	    record.errors.add("CPU Cooler does not exist") if CpuCooler.find_by_id(value) == nil
	end
	#Sockettype validations
	validates_length_of :sockettype, :maximum => 10
	validates_inclusion_of :sockettype, :in => %w(1336 1156 775 AM3), :message => "Socket type not supported"
	#Foreign key validations
	belongs_to :cpu_cooler
end
