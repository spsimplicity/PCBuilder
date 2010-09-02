class CpuCooler < ActiveRecord::Base
    
	#Parttype validations
	validates_length_of :parttype, :maximum => 15
	#Model validations
	validates_length_of :model, :maximum => 30
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Price, Maxmemheight, Height, Width, Length validations
	validates_numericality_of :price, :maxmemheight, :height, :width, :length, :greater_than => 0
	validates_presence_of :price, :height, :width, :length
end
