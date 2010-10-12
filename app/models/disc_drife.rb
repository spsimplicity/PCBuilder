class DiscDrife < ActiveRecord::Base
    
	#Nothin accessible via params
	attr_accessible
	#Part_id, Price validations
	validates_numericality_of :part_id, :price, :greater_than => 0
	validates_presence_of :part_id, :price
	validates_each :part_id do |record, attr, value|
	     record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Parttype validation
	validates_length_of :parttype, :maximum => 10
	validates_inclusion_of :parttype, :in => %w(Disc\ Drive), :message => "Part Type is no Disc Drive"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 30
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Model validations
	validates_length_of :model, :maximum => 20
	#Interface validation
	validates_length_of :interface, :maximum => 10
	validates_inclusion_of :interface, :in => %w(SATA IDE/PATA), :message => "Interface is not SATA or IDE/PATA"
	#Cache validations
	validates_numericality_of :cache, :greater_than => 0, :allow_nil => true
	#Drivetype validations
	validates_length_of :drivetype, :maximum => 15
	#Foreign key validations
    belongs_to :part
    has_many :read_speeds
	has_many :write_speeds
end
