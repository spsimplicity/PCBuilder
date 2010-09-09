class Incompatible < ActiveRecord::Base

    #No attributes are accessible for mass assignment
    attr_accessible
    #Part1_id, Part2_od validations
	validates_numericality_of :part1_id, :part2_id, :greater_than => 0
	validates_presence_of :part1_id, :part2_id
	validates_each :part1_id, :part2_id do |record, attr, value|
	    record.errors.add("Part does not exist") if Part.find_by_id(value) == nil
    end
	#Part2type. Part3type validations
	validates_length_of :part1type, :part2type, :maximum => 20
	validates_inclusion_of :part1type, :part2type, :in => %w(CPU Case Motherboard Memory Monitor Power\ Supply
		Hard\ Drive Disc\ Drive CPU\ Cooler Graphics\ Card), :message => "Parttype is not supported"
    #Foreign key validations
    belongs_to :part1
    belongs_to :part2
end
