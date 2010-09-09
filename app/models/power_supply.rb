class PowerSupply < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    attr_accessible
	#Parttype, Energycert validations
	validates_length_of :parttype, :energycert, :maximum => 20
	validates_inclusion_of :parttype, :in => %w(Power\ Supply), :message => "Part Type is not power supply"
	#Manufacturer, Model, Series validations
	validates_length_of :manufacturer, :model, :series, :maximum => 30
	#Manufacturerwebsite and Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Price, Fansize, Mainpower, Poweroutput, Length, Part_id validations
	validates_numericality_of :price, :fansize, :mainpower, :poweroutput, :length, :part_id,
	    :greater_than => 0
	validates_presence_of :price, :fansize, :mainpower, :poweroutput, :length, :part_id
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Satapower, Peripheral, Cpu4_4pin, Cpu4pin, Cpu8pin, Gpu8pin, Gpu6pin, Gpu6_2pin validations
	validates_numericality_of :satapower, :peripheral, :cpu4_4pin, :cpu4pin, :cpu8pin, 
	    :gpu8pin, :gpu6pin, :gpu6_2pin, :greater_than_or_equal_to => 0
	validates_presence_of :satapower, :peripheral, :cpu4_4pin, :cpu4pin, :cpu8pin, :gpu8pin, 
	    :gpu6pin, :gpu6_2pin
	#Multi_gpu validations
	validates_presence_of :multi_gpu
	#Power_supply_type validations
	validates_length_of :power_supply_type, :maximum => 40
	#Foreign key validations
	belongs_to :part, :autosave => true
end
