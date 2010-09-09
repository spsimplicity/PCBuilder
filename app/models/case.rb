class Case < ActiveRecord::Base

    #No attributes are accessible for mass assignment
    attr_accessible
	#Parttype validations
	validates_length_of :parttype, :maximum => 5
	validates_inclusion_of :parttype, :in => %w(Case), :message => "Part Type is not Case"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Price, Totalbays, Hddbays, Expansionslots, Discbays, Length, Width, Height, Part_id validations
	validates_numericality_of :price, :totalbays, :hddbays, :expansionslots, :discbays, 
	    :length, :width, :height, :part_id, :greater_than => 0
	validates_presence_of :price, :totalbays, :hddbays, :expansionslots, :discbays, :length,
	    :width, :height, :part_id
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Model and Series validations
	validates_length_of :series, :model, :maximum => 30
	#Manufacturerwebsite and Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Conversionbays, SSDBays validations
	validates_numericality_of :conversionbays, :ssdbays, :greater_than_or_equal_to => 0
	validates_presence_of :conversionbays, :ssdbays
	#Casetype validations
	validates_length_of :casetype, :maximum => 25
	#Foreign key validations
	has_many :case_motherboards, :foreign_key => "case_id", :autosave => true, :dependent => :destroy
	belongs_to :part, :autosave => true
end
