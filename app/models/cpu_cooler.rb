class CpuCooler < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    attr_accessible
	#Parttype validations
	validates_length_of :parttype, :maximum => 15
	validates_inclusion_of :parttype, :in => %w(cpu\ cooler Cpu\ Cooler CPU\ Cooler 
	    CPU\ cooler Cpu\ cooler), :message => "Part Type is not CPU Cooler"
	#Model validations
	validates_length_of :model, :maximum => 30
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Price, Maxmemheight, Height, Width, Length validations
	validates_numericality_of :price, :maxmemheight, :height, :width, :length, :greater_than => 0
	validates_presence_of :price, :height, :width, :length
	#Foreign key validations
	has_many :cpu_cooler_sockets, :foreign_key => "cpu_cooler_id", :autosave => true, :dependent => :destroy
end
