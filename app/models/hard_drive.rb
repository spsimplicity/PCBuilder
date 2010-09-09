class HardDrive < ActiveRecord::Base

    #No attributes are accessible for mass assignment
    attr_accessible
    belongs_to :part_id, :autosave => true
end
