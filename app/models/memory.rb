class Memory < ActiveRecord::Base
    
	#No variables are accessible via params
	attr_accessible
	#Part_id, Price, Speed, Capacity, Multichanneltype, Pinnumber, Dimms, Totalcapacity, Voltage validations
	validates_numericality_of :part_id, :price, :speed, :capacity, :multichanneltype,
  	    :pinnumber, :dimms, :totalcapacity, :voltage, :greater_than => 0
	validates_presence_of :part_id, :price, :speed, :capacity, :multichanneltype,
	    :pinnumber, :dimms, :totalcapacity, :voltage
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Parttype validations
	validates_length_of :parttype, :maximum => 10
	validates_inclusion_of :parttype, :in => %w(Memory), :message => "Part Type is not Memory"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Manufacturerwebsite, and Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Model validations
	validates_length_of :model, :maximum => 30
	#Series validations
	validates_length_of :series, :maximum => 30, :allow_nil => true
	#Timings validations
	validates_length_of :timings, :maximum => 10
	#Memorytype validations
	validates_length_of :memorytype, :maximum => 5
	validates_format_of :memorytype, :with => /DDR/, :message => "Memory type is not DDR"
	#Foreign key validations
    belongs_to :part
end
