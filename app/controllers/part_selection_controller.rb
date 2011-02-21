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
		elsif params[:part_type] == "Power Supplies"
			redirect_to :action => :psus
		elsif params[:part_type] == "Memory"
			redirect_to :action => :memory
		elsif params[:part_type] == "Cases"
			redirect_to :action => :cases
		else
			redirect_to :action => :displays
		end
	end
	
	def add_part
	    if session[:part_type] == "Motherboards"
		    mobo = Motherboard.find_by_part_id(params[:id].to_i)
		    session[:computer].motherboard_id = mobo.part_id
			session[:computer].price += (mobo.price*100)
		elsif session[:part_type] == "Processors"
		    cpu = Cpu.find_by_part_id(params[:id].to_i)
		    session[:computer].cpu_id = cpu.part_id
			session[:computer].price += (cpu.price*100)
		elsif session[:part_type] == "CPU Coolers" 
		    cooler = CpuCooler.find_by_part_id(params[:id].to_i)
		    session[:computer].cpu_cooler_id = cooler.part_id
			session[:computer].price += (cooler.price*100)
		elsif session[:part_type] == "Power Supplies"
		    power = PowerSupply.find_by_part_id(params[:id].to_i)
		    session[:computer].power_supply_id = power.part_id
			session[:computer].price += (power.price*100)
		elsif session[:part_type] == "Graphics Cards"
		    card = GraphicsCard.find_by_part_id(params[:id].to_i)
		    session[:computer].other_parts.push([card.part_id, "Graphics Card"])
			session[:computer].price += (card.price*100)
		elsif session[:part_type] == "Hard Drives"
		    hard = HardDrife.find_by_part_id(params[:id].to_i)
		    session[:computer].other_parts.push([hard.part_id, "Hard Drive"])
			session[:computer].price += (hard.price*100)
		elsif session[:part_type] == "Cases"
		    cse = Case.find_by_part_id(params[:id].to_i)
		    session[:computer].case_id = cse.part_id
			session[:computer].price += (cse.price*100)
		elsif session[:part_type] == "Disc Drives"
		    disc = DiscDrife.find_by_part_id(params[:id].to_i)
		    session[:computer].other_parts.push([disc.part_id, "Disc Drive"])
			session[:computer].price += (disc.price*100)
		elsif session[:part_type] == "Memory"
		    mem = Memory.find_by_part_id(params[:id].to_i)
		    session[:computer].other_parts.push([mem.part_id, "Memory"])
			session[:computer].price += (mem.price*100)
		else
		    dis = Display.find_by_part_id(params[:id].to_i)
		    session[:computer].other_parts.push([dis.part_id, "Display"])
			session[:computer].price += (dis.price*100)
		end
		redirect_to :controller => :part_categories, :action => :current
	end
    
	def reduceParts(parts, type, expSlotsTaken, maxExpSlots)
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
		if session[:computer].case_id && type != "Cases"
		    Incompatible.find_all_by_part1_id(session[:computer].case_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
		end
		session[:computer].other_parts.each do |part|
		    Incompatible.find_all_by_part1_id(part[0]).each do |inc|
			    parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
			if type == "Graphics Card" && maxExpSlots > 0
			    parts = parts.delete_if {|part| 
				    if part.width == "Dual"
					    (2 + expSlotsTaken) > maxExpSlots
					elsif part.width == "Triple"
					    (3 + expSlotsTaken) > maxExpSlots
					else
					    (1 + expSlotsTaken) > maxExpSlots
					end
			    }
			end
		end
		parts
	end
	
    def mobos
	    @parts = Motherboard.find(:all, :include => :memory_speeds)
		@parts = reduceParts(@parts, "Motherboards", nil, nil)
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
		@parts = reduceParts(@parts, "Processors", nil, nil)
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
		@parts = reduceParts(@parts, "CPU Coolers", nil, nil)
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
		@parts = reduceParts(@parts, "Disc Drives", nil, nil)
		session[:part_type] = "Disc Drives"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :parts
	end
	
	def gpus
		gpuCount = 0
		slotCount = 0
		maxSlots = 0
		session[:computer].other_parts.each do |part|
		    if part[1] == "Graphics Card"
			    gpuCount += 1
				gpu = GraphicsCard.find_by_part_id(part[0])
				if gpu.width == "Triple"
				    slotCount += 3
				elsif gpu.width == "Dual"
				    slotCount += 2
				else
				    slotCount += 1
				end
			end
		end
		@error = nil
		if session[:computer].motherboard_id
		    mobo = Motherboard.find_by_part_id(session[:computer].motherboard_id)
			if mobo.pci_ex16 == gpuCount
			    @error = "Currently selected motherboard can not fit anymore graphics cards"
			end
		end
		if session[:computer].case_id
		    pcCase = Case.find_by_part_id(session[:computer].case_id)
			maxSlots = pcCase.expansionslots
			if pcCase.expansionslots == slotCount
			    @error = "Currently selected case can not fit anymore graphics cards"
			end
		end
		if !@error
			@parts = GraphicsCard.find(:all)
			@parts = reduceParts(@parts, "Graphics Card", slotCount, maxSlots)
			if (@parts.length % 10) == 10
				session[:max] = @parts.length / 10
			else
				session[:max] = (@parts.length / 10) + 1
			end
		else
		    @parts = []
		end
		session[:part_type] = "Graphics Cards"		
		render :parts
	end
	
	def hdds
	    @parts = HardDrife.find(:all)
		@parts = reduceParts(@parts, "Hard Drives", nil, nil)
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
		@parts = reduceParts(@parts, "Power Supplies", nil, nil)
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
		@parts = reduceParts(@parts, "Memory", nil, nil)
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
		@parts = reduceParts(@parts, "Cases", nil, nil)
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
		@parts = reduceParts(@parts, "Displays", nil, nil)
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
		elsif session[:part_type] == "Power Supplies"
			redirect_to :action => :psus
		elsif session[:part_type] == "Memory"
			redirect_to :action => :memory
		elsif session[:part_type] == "Cases"
			redirect_to :action => :cases
		else
			redirect_to :action => :displays
		end
	end
end
