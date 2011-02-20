class PartSelectionController < ApplicationController
    def init
	    session[:page_num] = 1
		if params[:part_type] == "Motherboards"
			redirect_to :action => :mobos
		elsif params[:part_type] == "Processors"
			redirect_to :action => :cpus
		elsif params[:part_type] == "CPU Coolers"
			redirect_to :action => :coolers
		elsif params[:part_type] == "Disc Drives"
			redirect_to :action => :discs
		elsif params[:part_type] == "Graphics Cards"
			redirect_to :action => :gpus
		elsif params[:part_type] == "Hard Drives"
			redirect_to :action => :hdds
		elsif params[:part_type] = "Power Supplies"
			redirect_to :action => :psus
		elsif params[:part_type] = "Memory"
			redirect_to :action => :memory
		elsif params[:part_type] = "Cases"
			redirect_to :action => :cases
		else
			redirect_to :action => :displays
		end
	end
	
	def add_part
	    if session[:part_type] == "Motherboards"
		    session[:computer].motherboard_id = Motherboard.find_by_part_id(params[:id].to_i).part_id
		elsif session[:part_type] == "Processors"
		    session[:computer].cpu_id = Cpu.find_by_part_id(params[:id].to_i).part_id
		elsif session[:part_type] == "CPU Coolers" 
		    session[:computer].cpu_cooler_id = CpuCooler.find_by_part_id(params[:id].to_i).part_id
		elsif session[:part_type] == "Power Supplies"
		    session[:computer].power_supply_id = PowerSupply.find_by_part_id(params[:id].to_i).part_id
		elsif session[:part_type] == "Graphics Cards"
		    session[:computer].other_parts.push([GraphicsCard.find_by_part_id(params[:id].to_i).part_id, "Graphics Card"])
		elsif session[:part_type] == "Hard Drives"
		    session[:computer].other_parts.push([HardDrife.find_by_part_id(params[:id].to_i).part_id, "Hard Drive"])
		else
		end
		redirect_to :controller => :part_categories, :action => :current
	end
    
	def reduceParts(parts, type)
	    if session[:computer].motherboard_id && type != "Motherboards"
		    Incompatible.find_all_by_part1_id(session[:computer].motherboard_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
		end
		if session[:computer].cpu_id && type != "Processors"
		    Incompatible.find_all_by_part1_id(session[:computer].cpu_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
		end
		if session[:computer].cpu_cooler_id && type != "CPU Coolers"
		    Incompatible.find_all_by_part1_id(session[:computer].cpu_cooler_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
		end
		if session[:computer].power_supply_id && type != "Power Supplies"
		    Incompatible.find_all_by_part1_id(session[:computer].power_supply_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
		end
		parts
	end
	
    def mobos
	    @parts = Motherboard.find(:all, :include => :memory_speeds)
		@parts = reduceParts(@parts, "Motherboards")
		session[:part_type] = "Motherboards"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def cpus
	    @parts = Cpu.find(:all)
		@parts = reduceParts(@parts, "Processors")
		session[:part_type] = "Processors"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def coolers
	    @parts = CpuCooler.find(:all, :include => :cpu_cooler_sockets)
		@parts = reduceParts(@parts, "CPU Coolers")
		session[:part_type] = "CPU Coolers"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def discs
	    @parts = DiscDrife.find(:all, :include => {:write_speeds, :read_speeds})
		@parts = reduceParts(@parts, "Disc Drives")
		session[:part_type] = "Disc Drives"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def gpus
	    @parts = GraphicsCard.find(:all)
		@parts = reduceParts(@parts, "Graphics Card")
		session[:part_type] = "Graphics Cards"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def hdds
	    @parts = HardDrife.find(:all)
		@parts = reduceParts(@parts, "Hard Drives")
		session[:part_type] = "Hard Drives"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def psus
	    @parts = PowerSupply.find(:all)
		@parts = reduceParts(@parts, "Power Supplies")
		session[:part_type] = "Power Supplies"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def memory
	    @parts = Memory.find(:all)
		@parts = reduceParts(@parts, "Memory")
		session[:part_type] = "Memory"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def cases
	    @parts = Case.find(:all, :include => :case_motherboards)
		@parts = reduceParts(@parts, "Cases")
		session[:part_type] = "Cases"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def displays
	    @parts = Display.find(:all)
		@parts = reduceParts(@parts, "Displays")
		session[:part_type] = "Displays"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def previous
	    if session[:page_num] > 1
	        session[:page_num] -= 1
		end
		redirect_to :action => :type_determine
	end
	
	def next
	    if session[:page_num] < session[:max]
		    session[:page_num] += 1
		end
		redirect_to :action => :type_determine
	end
	
	def jump
	    session[:page_num] = params[:num].to_i
		redirect_to :action => :type_determine
	end
	
	def type_determine
	    if session[:part_type] == "Motherboards"
			redirect_to :action => :mobos
		elsif session[:part_type] == "Processors"
			redirect_to :action => :cpus
		elsif session[:part_type] == "CPU Coolers"
			redirect_to :action => :coolers
		elsif session[:part_type] == "Disc Drives"
			redirect_to :action => :discs
		elsif session[:part_type] == "Graphics Cards"
			redirect_to :action => :gpus
		elsif session[:part_type] == "Hard Drives"
			redirect_to :action => :hdds
		elsif session[:part_type] = "Power Supplies"
			redirect_to :action => :psus
		elsif session[:part_type] = "Memory"
			redirect_to :action => :memory
		elsif session[:part_type] = "Cases"
			redirect_to :action => :cases
		else
			redirect_to :action => :displays
		end
	end
end
