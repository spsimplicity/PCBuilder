class Part < ActiveRecord::Base
    
	#No attributes are accessible for mass assignment
    attr_accessible
	#Parttype validations
	validates_length_of :parttype, :maximum => 20
	validates_inclusion_of :parttype, :in => %w(CPU Case Motherboard Memory Monitor Power\ Supply
		Hard\ Drive Disc\ Drive CPU\ Cooler Graphics\ Card), :message => "Parttype is not supported"
	#Foreign key validations
	has_many :cpus, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :motherboards, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :cases, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :power_supplies, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :cpu_coolers, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :has_parts, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	belongs_to :incompatibles, :foreign_key => "part2_id", :autosave => true, :dependent => :destroy
	has_many :incompatibles, :foreign_key => "part1_id", :autosave => true, :dependent => :destroy
	has_many :hard_drives, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :disc_drives, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :gaphics_carts, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :monitors, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
	has_many :memorys, :foreign_key => "part_id", :autosave => true, :dependent => :destroy
end
