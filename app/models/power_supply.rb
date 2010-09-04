class PowerSupply < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    attr_accessible
	#Parttype, Energycert validations
	validates_length_of :parttype, :energycert, :maximum => 20
	validates_inclusion_of :parttype, :in => %w(Power\ Supply power\ supply Power\ supply), 
	    :message => "Part Type is not power supply"
	#Manufacturer, Model, Series validations
	validates_length_of :manufacturer, :model, :series, :maximum => 30
	#Manufacturerwebsite and Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Price, Fansize, Mainpower, Poweroutput, Length validations
	validates_numericality_of :price, :fansize, :mainpower, :poweroutput, :length, :greater_than => 0
	validates_presence_of :price, :fansize, :mainpower, :poweroutput, :length
	#Satapower, Peripheral, Cpu4_4pin, Cpu4pin, Cpu8pin, Gpu8pin, Gpu6pin, Gpu6_2pin validations
	validates_numericality_of :satapower, :peripheral, :cpu4_4pin, :cpu4pin, :cpu8pin, 
	    :gpu8pin, :gpu6pin, :gpu6_2pin, :greater_than_or_equal_to => 0
	validates_presence_of :satapower, :peripheral, :cpu4_4pin, :cpu4pin, :cpu8pin, :gpu8pin, 
	    :gpu6pin, :gpu6_2pin
	#Multi_gpu validations
	validates_presence_of :multi_gpu
	#Power_supply_type validations
	validates_length_of :power_supply_type, :maximum => 40
end
