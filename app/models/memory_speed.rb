class MemorySpeed < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    attr_accessible
	#Meotherboard_id validations
	validates_numericality_of :motherboard_id, :greater_than => 0
	validates_each :motherboard_id do |record, attr, value|
        begin
	        find(value)
        rescue => msg
	        record.errors.add(attr, msg)
	    end
    end
	#Speed validations
	validates_numericality_of :speed, :greater_than => 0
	#Foreign key validations
    belongs_to :motherboard, :autosave => true
end
