class GraphicsCard < ActiveRecord::Base
    
	#No attributes accessible via params
	attr_accessible
	#Part_id, Price, Coreclock, Memoryclock, Memorysize, DirectX, Length, Minpower, Power6pin, Power8pin validations
	validates_numericality_of :part_id, :price, :coreclock, :memoryclock, :directx, :length,
	    :minpower, :power6pin, :power8pin, :memorysize, :greater_than => 0
	validates_presence_of :part_id, :price, :coreclock, :memoryclock, :directx, :length,
	    :minpower, :power6pin, :power8pin, :memorysize
	validates_each :part_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
	end
	#Parttype validations
	validates_length_of :parttype, :maximum => 15
	validates_inclusion_of :parttype, :in => %w(Graphics\ Card), :message => "Part Type is not Graphics Card"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 20
	#Chipmanufacturer, Width, GPU, Maxresolution validations
	validates_length_of :chipmanufacturer, :width, :gpu, :maxresolution, :maximum => 10
	#Model validations
	validates_length_of :model, :maximum => 50
	#Series validations
	validates_length_of :series, :maximum => 30, :allow_nil => true
	#Shaderclock, Multigpupower validations
	validates_numericality_of :shaderclock, :multigpupower, :greater_than => 0, :allow_nil => true
	#Memorytype validations
	validates_length_of :memorytype, :maximum => 5
	#Interface validations
	validates_length_of :interface, :maximum => 15
	#Multigpusupport validations
	validates_inclusion_of :multigpusupport, :in => [true, false]
	#HDMI, DVI, Displayport, VGA, Svideo validations
	validates_numericality_of :hdmi, :dvi, :displayport, :vga, :svideo, :greater_than_or_equal_to => 0
	validates_presence_of :hdmi, :dvi, :displayport, :vga, :svideo
	#Manufacturerwebsite, Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Foreign key validations
    belongs_to :part
end
