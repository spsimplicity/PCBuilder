class Display < ActiveRecord::Base

    #Nothing accessible via params
	attr_accessible
	#Part_id, Price validations
	validates_numericality_of :part_id, :price, :greater_than => 0
	validates_presence_of :part_id, :price
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Parttype validations
	validates_length_of :parttype, :maximum => 10
	validates_inclusion_of :parttype, :in => %w(Monitor), :message => "Part Type is not Monitor"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Model validations
	validates_length_of :model, :maximum => 30
	#ContrastRatio validations
	validates_length_of :contrastratio, :maximum => 15
	#Length, Width, Height, Screensize validations
	validates_numericality_of :length, :width, :height, :screensize, :greater_than => 0
	validates_presence_of :length, :width, :height, :screensize
	#Resolution validations
	validates_length_of :resolution, :maximum => 15
	#Monitortype validations
	validates_length_of :monitortype, :maximum => 5
	validates_inclusion_of :monitortype, :in => %w(LCD LFD), :message => "Monitortype is not LCD, or LFD"
	#Widescreen validations
	validates_inclusion_of :widescreen, :in => [true, false]
	#Displaycolors validations
	validates_numericality_of :displaycolors, :greater_than => 0
	validates_presence_of :displaycolors
	#VGA, HDMI, SVideo, DVI, Displayport validations
	validates_numericality_of :vga, :hdmi, :svideo, :dvi, :displayport, :greater_than_or_equal_to => 0
	validates_presence_of :vga, :hdmi, :svideo, :dvi, :displayport
    #Foreign key validations
    belongs_to :part
end
