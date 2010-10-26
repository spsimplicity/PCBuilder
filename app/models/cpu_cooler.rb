class CpuCooler < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    #attr_accessible
	#Parttype validations
	validates_length_of :parttype, :maximum => 15
	validates_inclusion_of :parttype, :in => %w(CPU\ Cooler), :message => "Part Type is not CPU Cooler"
	#Model validations
	validates_length_of :model, :maximum => 30
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Price, Maxmemheight, Height, Width, Length, Part_id validations
	validates_numericality_of :price, :maxmemheight, :height, :width, :length, :part_id, :greater_than => 0, :allow_nil => true
	validates_presence_of :price, :height, :width, :length, :part_id
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Foreign key validations
	has_many :cpu_cooler_sockets, :foreign_key => "cpu_cooler_id", :autosave => true, :dependent => :destroy
	belongs_to :part, :autosave => true
end
