class ReadSpeed < ActiveRecord::Base

    #Nothing is accessible via params
	attr_accessible
	#Disc_drive_id, Speed validations
	validates_numericality_of :disc_drife_id, :speed, :greater_than => 0
	validates_presence_of :disc_drife_id, :speed
	validates_each :disc_drife_id do |record, attr, value|
	    record.errors.add("Disc_drive does not exist") if DiscDrife.find_by_id(value) == nil
	end
	#Readtype validations
	validates_length_of :readtype, :maximum => 15
	#Foreign key validations
    belongs_to :disc_drife
end
