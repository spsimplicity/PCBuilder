class Cpu < ActiveRecord::Base

    #No attributes are accessible for mass assignment
    attr_accessible
    #Part Type Validations
    validates_length_of :parttype, :maximum => 10
	validates_inclusion_of :parttype, :in => %w(CPU), :message => "Part Type is not CPU"
	#Model Validations
	validates_length_of :model, :maximum => 10
	#Manufacturer Validations
	validates_length_of :manufacturer, :maximum => 10
	#Series Validations
	validates_length_of :series, :maximum => 30
	#Price, Frequency, FSB, Cores, Watts, PowerPin, Maxmemory, Memchanneltype, Part_id Validations
	validates_numericality_of :price, :frequency, :fsb, :cores, :watts, :powerpin, :part_id,
	    :maxmemory, :memchanneltype, :only_integer => true, :greater_than => 0
	validates_presence_of :price, :frequency, :fsb, :cores, :watts, :powerpin, 
	    :maxmemory, :memchanneltype, :part_id
	validates_each :part_id do |record, attr, value|
		begin
			find(value)
		rescue => msg
			record.errors.add(attr, msg)
		end
	end
	#Manufacturer Website Validations
	validates_length_of :manufacturerwebsite, :maximum => 255
	#Googleprice Website Validations
	validates_length_of :googleprice, :maximum => 255
	#Frequency Validations
    validates_numericality_of :frequency, :only_integer => true, :greater_than => 0
    validates_presence_of :frequency
	#Sockettype Validations
	validates_length_of :sockettype, :maximum => 15
	#Cache Validations
	validates_numericality_of :l1cache, :l2cache, :l3cache, :only_integer => true, 
	    :greater_than_equal_to => 0
	#Foreign key validations	
	belongs_to :part, :autosave => true
end
