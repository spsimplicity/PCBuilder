class Motherboard < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    attr_accessible
	#Parttype validations
    validates_length_of :parttype, :maximum => 15
	validates_inclusion_of :parttype, :in => %w(motherboard Motherboard), 
	    :message => "Part Type is not motherboard"
	#Manufacturer validations
	validates_length_of :manufacturer, :maximum => 15
	#Model validations
	validates_length_of :model, :maximum => 40
	#Price, Maxmemory, Memoryslots, Cpupowerpin, Fsb, Mainpower validations
	validates_numericality_of :price, :maxmemory, :memoryslots, :cpupowerpin, :fsb, :mainpower, 
	    :greater_than => 0
	validates_presence_of :price, :maxmemory, :memoryslots, :cpupowerpin, :fsb, :mainpower
	#Manufacturerwebsite and Googleprice validations
	validates_length_of :manufacturerwebsite, :googleprice, :maximum => 255
	#Memorytype validations
	validates_length_of :memorytype, :maximum => 5
	validates_inclusion_of :memorytype, :in => %w(DDR3 DDR2 DDR DDR4 DDR5),
 	    :message => "Memorytype is not a supported type"
	#PCI_EX16, PCI_E2, PCI_E, PCI, Sata3, Sata6, IDE validations
	validates_numericality_of :pci_ex16, :pci_e2, :pci_e, :pci, :sata3, :sata6, :ide, 
	    :greater_than_or_equal_to => 0
	validates_presence_of :pci_ex16, :pci_e2, :pci_e, :pci, :sata3, :sata6, :ide
	#Size validations
	validates_length_of :size, :maximum => 15
	validates_inclusion_of :size, :in => %w(Micro\ ATX ATX EATX XL\ ATX), 
	    :message => "Size is not a standard size"
	#Northbridge and Southbridge validations
	validates_length_of :northbridge, :southbridge, :maximum => 25
	validates_presence_of :northbridge
	#Sli_Crossfire validations
	validates_presence_of :sli_crossfire	
	#Sockettype validations
	validates_length_of :sockettype, :maximum => 10
	#Foreign key validations
	has_many :memory_speeds, :foreign_key => "motherboard_id", :autosave => true, :dependent => :destroy
end
