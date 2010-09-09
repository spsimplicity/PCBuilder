class HasPart < ActiveRecord::Base

    #No attributes are accessible for mass assignment
    attr_accessible
	#Computer_id, Part_id validations
	validates_numericality_of :computer_id, :part_id, :greater_than => 0
	validates_presence_of :computer_id, :part_id
	validates_each :computer_id do |record, attr, value|
        record.errors.add("Computer does not exist") if Computer.find_by_id(value) == nil
    end
	validates_each :part_id do |record, attr, value|
        record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
    end
	#Parttype validations
	validates_length_of :parttype, :maximum => 20
	validates_inclusion_of :parttype, :in => %w(CPU Case Motherboard Memory Monitor Power\ Supply
		Hard\ Drive Disc\ Drive CPU\ Cooler Graphics\ Card), :message => "Parttype is not supported"
	#Foreign key validations
    belongs_to :computer, :autosave => true
    belongs_to :part, :autosave => true
end
