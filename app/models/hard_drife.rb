class HardDrife < ActiveRecord::Base
    
	#Nothing is accessbile via prams
	attr_accessible
	#Part_id validations
	validates_numericality_of :part_id, :greater_than => 0
	validates_presence_of :part_id
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Parttype validations
	validates_length_of :parttype, :maximum => 15
	validates_inclusion_of :parttype, :in => %w(Hard\ Drive), :message => "Part type is not Hard Drive"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Model validations
	validates_length_of :model, :maximum => 30
	#Series validations
	validates_length_of :series, :maximum => 20, :allow_nil => true
	#Price, Capacity, RPM validations
	validates_numericality_of :price, :capacity, :rpm, :greater_than => 0
	validates_presence_of :price, :capacity, :rpm
	#Cache validations
	validates_numericality_of :cache, :greater_than => 0, :allow_nil => true
	#Interface validations
	validates_length_of :interface, :maximum => 10
	validates_inclusion_of :interface, :in => %w(SATA\ 3 SATA\ 6 IDE/PATA), :message => "Interface is not SATA 3/6 or IDE/PATA"
    #Foreign key validations
    belongs_to :part, :autosave => true
end
