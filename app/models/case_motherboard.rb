class CaseMotherboard < ActiveRecord::Base

    #No attributes are accessible for mass assignment
    attr_accessible
	#Case id validations
	validates_numericality_of :case_id, :greater_than => 0
	validates_presence_of :case_id
	validates_each :case_id do |record, attr, value|
	    record.errors.add("Case does not exist") if Case.find_by_id(value) == nil
    end
	#Size validations
	validates_length_of :size, :maximum => 15
	validates_inclusion_of :size, :in => %w(Micro\ ATX ATX EATX XL\ ATX), 
	    :message => "Size is not a standard size"
	#Foreign key validations
    belongs_to :case
end
