class PartSelectionController < ApplicationController
    def init
	    session[:page_num] = 1
		if params[:part_type] == "Motherboards"
			redirect_to :action => :mobos, :change => params[:change]
		elsif params[:part_type] == "Processors"
			redirect_to :action => :cpus, :change => params[:change]
		elsif params[:part_type] == "CPU Coolers"
			redirect_to :action => :coolers, :change => params[:change]
		elsif params[:part_type] == "Disc Drives"
			redirect_to :action => :discs, :change => params[:change]
		elsif params[:part_type] == "Graphics Cards"
			redirect_to :action => :gpus, :change => params[:change]
		elsif params[:part_type] == "Hard Drives"
			redirect_to :action => :hdds, :change => params[:change]
		elsif params[:part_type] == "Power Supplies"
			redirect_to :action => :psus, :change => params[:change]
		elsif params[:part_type] == "Memory"
			redirect_to :action => :memory, :change => params[:change]
		elsif params[:part_type] == "Cases"
			redirect_to :action => :cases, :change => params[:change]
		else
			redirect_to :action => :displays, :change => params[:change]
		end
	end
	
	def add_part
	    if session[:part_type] == "Motherboards"
		    mobo = Motherboard.find_by_part_id(params[:id].to_i)
			if (params[:didChange] || session[:computer].motherboard_id)
			    session[:computer].price -= Motherboard.find_by_part_id(session[:computer].motherboard_id).price
			end
		    session[:computer].motherboard_id = mobo.part_id
			session[:computer].price += (mobo.price)
		elsif session[:part_type] == "Processors"
		    cpu = Cpu.find_by_part_id(params[:id].to_i)
			if (params[:didChange] || session[:computer].cpu_id)
			    session[:computer].price -= Cpu.find_by_part_id(session[:computer].cpu_id).price 
			end
		    session[:computer].cpu_id = cpu.part_id
			session[:computer].price += (cpu.price)
		elsif session[:part_type] == "CPU Coolers" 
		    cooler = CpuCooler.find_by_part_id(params[:id].to_i)
			if (params[:didChange] || session[:computer].cpu_cooler_id)
			    session[:computer].price -= CpuCooler.find_by_part_id(session[:computer].cpu_cooler_id).price 
			end
		    session[:computer].cpu_cooler_id = cooler.part_id
			session[:computer].price += (cooler.price)
		elsif session[:part_type] == "Power Supplies"
		    power = PowerSupply.find_by_part_id(params[:id].to_i)
			if (params[:didChange] || session[:computer].power_supply_id)
			    session[:computer].price -= PowerSupply.find_by_part_id(session[:computer].power_supply_id).price 
			end
		    session[:computer].power_supply_id = power.part_id
			session[:computer].price += (power.price)
		elsif session[:part_type] == "Graphics Cards"
		    card = GraphicsCard.find_by_part_id(params[:id].to_i)
			if params[:didChange]
			    session[:computer].price -= GraphicsCard.find_by_part_id(params[:didChange].to_i).price 
				remove(params[:didChange].to_i)
			end
		    session[:computer].other_parts.push([card.part_id, "Graphics Card"])
			session[:computer].price += (card.price)
		elsif session[:part_type] == "Hard Drives"
		    hard = HardDrife.find_by_part_id(params[:id].to_i)
			if params[:didChange]
			    session[:computer].price -= HardDrife.find_by_part_id(params[:didChange].to_i).price 
				remove(params[:didChange].to_i)
			end
		    session[:computer].other_parts.push([hard.part_id, "Hard Drive", hard.interface])
			session[:computer].price += (hard.price)
		elsif session[:part_type] == "Cases"
		    cse = Case.find_by_part_id(params[:id].to_i)
			if (params[:didChange] || session[:computer].case_id)
			    session[:computer].price -= Case.find_by_part_id(session[:computer].case_id).price 
			end
		    session[:computer].case_id = cse.part_id
			session[:computer].price += (cse.price)
		elsif session[:part_type] == "Disc Drives"
		    disc = DiscDrife.find_by_part_id(params[:id].to_i)
			if params[:didChange]
			    session[:computer].price -= DiscDrife.find_by_part_id(params[:didChange].to_i).price 
				remove(params[:didChange].to_i)
			end
		    session[:computer].other_parts.push([disc.part_id, "Disc Drive", disc.interface])
			session[:computer].price += (disc.price)
		elsif session[:part_type] == "Memory"
		    mem = Memory.find_by_part_id(params[:id].to_i)
			if params[:didChange]
			    session[:computer].price -= Memory.find_by_part_id(params[:didChange].to_i).price 
				remove(params[:didChange].to_i)
			end
		    session[:computer].other_parts.push([mem.part_id, "Memory", mem.dimms, mem.totalcapacity])
			session[:computer].price += (mem.price)
		else
		    dis = Display.find_by_part_id(params[:id].to_i)
			if params[:didChange]
			    session[:computer].price -= Display.find_by_part_id(params[:didChange].to_i).price 
				remove(params[:didChange].to_i)
			end
		    session[:computer].other_parts.push([dis.part_id, "Display"])
			session[:computer].price += (dis.price)
		end
		redirect_to :controller => :part_categories, :action => :current
	end
	
	def remove(part_id)
	    deleted = false
		spot = 0
	    while spot < session[:computer].other_parts.length && !deleted
			if session[:computer].other_parts[spot][0] == part_id
			    session[:computer].other_parts.delete_at(spot)
			    deleted = true
			end
			spot += 1
		end
	end
    
	def reduceParts(parts, type, constraints)
	    if session[:computer].motherboard_id && type != "Motherboards"
		    Incompatible.find_all_by_part1_id(session[:computer].motherboard_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
			#Constraints => [sata3Count, sata3PortCount, sata6Count, sata6PortCount, ideCount, idePortCount, dSataCount, dIdeCount, sataPowerCount, idePowerCount]
			if type == "Hard Drives" && (constraints[0] > 0 || constraints[2] > 0 || constraints[4] > 0)
			    parts = parts.delete_if {|part|
				    if part.interface == "SATA 3"
					    ((constraints[0] + constraints[6]) == constraints[1])
					elsif part.interface == "SATA 6"
					    (constraints[2] == constraints[3])
					else
					    ((constraints[4] + constraints[7]) == constraints[5])
					end
				}
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
			#Constraints => [sata3Count, sata3PortCount, sata6Count, sata6PortCount, ideCount, idePortCount, dSataCount, dIdeCount, sataPowerCount, idePowerCount]
			if type == "Hard Drives" && (constraints[0] > 0 || constraints[2] > 0 || constraints[4] > 0)
			    parts = parts.delete_if {|part|
				    if part.interface == "SATA 3"
						((constraints[0] + constraints[2] + constraints[6]) == constraints[8])
					elsif part.interface == "SATA 6"
						((constraints[0] + constraints[2] + constraints[6]) == constraints[8])
					else
						((constraints[4] + constraints[7]) == constraints[9])
					end
				}
			end
		end
		if session[:computer].case_id && type != "Cases"
		    Incompatible.find_all_by_part1_id(session[:computer].case_id).each do |inc|
				parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
			#Constraints => [slotCount, maxSlotCount]
			if type == "Graphics Cards" && constraints[1] > 0
			    parts = parts.delete_if {|part| 
				    if part.width == "Dual"
					    (2 + constraints[0]) > constraints[1]
					elsif part.width == "Triple"
					    (3 + constraints[0]) > constraints[1]
					else
					    (1 + constraints[0]) > constraints[1]
					end
			    }
			end
		end
		session[:computer].other_parts.each do |otherPart|
		    Incompatible.find_all_by_part1_id(otherPart[0]).each do |inc|
			    parts = parts.delete_if {|part| part.part_id == inc.part2_id}
			end
			if otherPart[1] == "Graphics Card" && type != "Graphics Cards"
			    #Constraints => [memoryslots, totalMem, hSata3Count, hSata6Count, hIdeCount, dSataCount, dIdeCount, gpuCount]
				if type == "Motherboards"
					parts = parts.delete_if {|part| constraints[7] > part.pci_ex16}
				end
			end
			if otherPart[1] == "Memory" && type != "Memory"
			    #Constraints => [memoryslots, totalMem, hSata3Count, hSata6Count, hIdeCount, dSataCount, dIdeCount, gpuCount]
				if type == "Motherboards"
					parts = parts.delete_if {|part| (constraints[0] > part.memoryslots) ||
					                                (constraints[1] > part.maxmemory)
					}
				end
			end
			if otherPart[1] ==  "Hard Drive" && type != "Hard Drives"
				#Constraints => [memoryslots, totalMem, hSata3Count, hSata6Count, hIdeCount, dSataCount, dIdeCount, gpuCount]
			    if type == "Motherboards"
					parts = parts.delete_if {|part| (constraints[4] > part.ide - constraints[6]) ||
					                                (constraints[3] > part.sata6 - (constraints[2] + constraints[5] > part.sata3 ? (constraints[2] + constraints[5]) - part.sata3 : 0)) ||
					                                (constraints[2] > part.sata3 + part.sata6 - constraints[3] - constraints[5])
					}
				end
			end
			if otherPart[1] ==  "Disc Drive" && type != "Disc Drives"
			end
			if otherPart[1] ==  "Display" && type != "Displays"
			end
		end
		parts
	end
	
    def mobos
	    @error = nil
		memoryslots = 0
		totalMem = 0
		hSata3Count = 0
		hSata6Count = 0
		hIdeCount = 0
		dSataCount = 0
		dIdeCount = 0
		gpuCount = 0
		session[:computer].other_parts.each do |part|
		    if part[1] == "Memory"
			    memoryslots += part[2]
				totalMem += part[3]
			elsif part[1] == "Hard Drive"
			    if part[2] == "SATA 3"
				    hSata3Count += 1
				elsif part[2] == "SATA 6"
				    hSata6Count += 1
				else
				    hIdeCount += 1
				end
			elsif part[1] == "Disc Drive"
			    if part[2] == "SATA"
				    dSataCount += 1
				else
				    dIdeCount += 1
				end
			elsif part[1] == "Graphics Card"
			    gpuCount += 1
			end
		end
		
		if !@error
			@parts = Motherboard.find(:all, :include => :memory_speeds)
			@parts = reduceParts(@parts, "Motherboards", [memoryslots, totalMem, hSata3Count, hSata6Count, hIdeCount, dSataCount, dIdeCount, gpuCount])
			if (@parts.length % 10) == 10
				session[:max] = @parts.length / 10
			else
				session[:max] = (@parts.length / 10) + 1
			end
		else
		   @parts = []
		end
		session[:part_type] = "Motherboards"
		@changing = params[:change]
		render :parts
	end
	
	def cpus
	    @parts = Cpu.find(:all)
		@parts = reduceParts(@parts, "Processors", [])
		session[:part_type] = "Processors"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def coolers
	    @parts = CpuCooler.find(:all, :include => :cpu_cooler_sockets)
		@parts = reduceParts(@parts, "CPU Coolers", [])
		session[:part_type] = "CPU Coolers"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def discs
	    @parts = DiscDrife.find(:all, :include => {:write_speeds, :read_speeds})
		@parts = reduceParts(@parts, "Disc Drives", [])
		session[:part_type] = "Disc Drives"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def gpus
		@error = nil
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
		
		if session[:computer].motherboard_id
		    mobo = Motherboard.find_by_part_id(session[:computer].motherboard_id)
			if mobo.pci_ex16 == 0
			    @error = "No PCI Express slots on selected motherboard. Cannot fit a graphics card."
			elsif mobo.pci_ex16 == gpuCount
			    @error = "No more PCI Express slots availbable on selected motherboard. Cannot fit another graphics card."
			end
		end
		if session[:computer].case_id
		    pcCase = Case.find_by_part_id(session[:computer].case_id)
			maxSlots = pcCase.expansionslots
			if pcCase.expansionslots == slotCount
			    @error = "Not enough expansion slots on selected case. Cannot fit another graphics card."
			end
		end
		
		if !@error
			@parts = GraphicsCard.find(:all)
			@parts = reduceParts(@parts, "Graphics Cards", [slotCount, maxSlots])
			if (@parts.length % 10) == 10
				session[:max] = @parts.length / 10
			else
				session[:max] = (@parts.length / 10) + 1
			end
		else
		    @parts = []
		end
		session[:part_type] = "Graphics Cards"
		@changing = params[:change]		
		render :parts
	end
	
	def hdds
	    @error = nil
		@potentialError = ""
		hddCount = 0
		ideCount = 0
		sata3Count = 0
		sata6Count = 0
		ddCount = 0
		dSataCount = 0
		dIdeCount = 0
		maxBays = 0
		bayCount = 0
		idePortCount = 0
		sata3PortCount = 0
		sata6PortCount = 0
		sataPowerCount = 0
		idePowerCount = 0
		session[:computer].other_parts.each do |part|
		    if part[1] == "Hard Drive"
			    hddCount += 1
				if part[2] == "SATA 3"
				    sata3Count += 1
				elsif part[2] == "SATA 6"
				    sata6Count += 1
				else
				    ideCount += 1
				end
			elsif part[1] == "Disc Drive"
			    ddCount += 1
				if part[2] == "SATA"
				    dSataCount += 1
				else
				    dIdeCount += 1
			    end
			end
		end
		if session[:computer].case_id
		    pcCase = Case.find_by_part_id(session[:computer].case_id)			
			if ddCount > pcCase.discbays - pcCase.conversionbays
			    maxBays = pcCase.hddbays + (pcCase.discbays - ddCount)
			else
			    maxBays = pcCase.hddbays + pcCase.conversionbays
			end
			if maxBays == hddCount
			    @error = "No more hard drive bays availbable in the selected case. Cannot fit another hard drive."
			end
		end
		if session[:computer].motherboard_id
		    mobo = Motherboard.find_by_part_id(session[:computer].motherboard_id)
			idePortCount = mobo.ide
			sata3PortCount = mobo.sata3
			sata6PortCount = mobo.sata6
			if (sata3Count + sata6Count + dSataCount == sata3PortCount + sata6PortCount) && (idePortCount == 0)
			    @error = "No more SATA ports available for another hard drive on the selected motherboard."
			elsif (sata3Count + sata6Count + dSataCount == sata3PortCount + sata6PortCount) && (ideCount + dIdeCount == idePortCount)
			    @error = "No more SATA or IDE ports available for another hard drive on the selected motherboard."
			end
			
			if sata3Count + sata6Count + dSataCount >= sata3PortCount + sata6PortCount
			    @potentialError += "No more SATA ports available for another hard drive on the selected motherboard."
			end
			if ideCount + dIdeCount >= idePortCount
			    @potentialError += " No more IDE ports available for another hard drive on the selected motherboard."
			end
		end
		if session[:computer].power_supply_id
		    psu = PowerSupply.find_by_part_id(session[:computer].power_supply_id)
			sataPowerCount = psu.satapower
		    idePowerCount = psu.peripheral
			if (sata3Count + sata6Count + dSataCount == sataPowerCount) && (ideCount + dIdeCount == idePowerCount)
			    @error = "No more SATA or Peripheral power connectors available on the selected power supply."
			elsif sata3Count + sata6Count + dSataCount == sataPowerCount
			    @potentialError += " No more SATA power connectors available on the selected power supply."
			elsif ideCount + dIdeCount == idePowerCount
			    @potentialError += " No more Peripheral power connectors available on the selected power supply."
			end
		end
		
		if !@error
			@parts = HardDrife.find(:all)
			@parts = reduceParts(@parts, "Hard Drives", [sata3Count, sata3PortCount, sata6Count, sata6PortCount, ideCount, idePortCount, dSataCount, dIdeCount, sataPowerCount, idePowerCount])
			if (@parts.length % 10) == 10
				session[:max] = @parts.length / 10
			else
				session[:max] = (@parts.length / 10) + 1
			end
		else
		    @parts = []
		end
		session[:part_type] = "Hard Drives"
		@changing = params[:change]
		render :parts
	end
	
	def psus
	    @parts = PowerSupply.find(:all)
		@parts = reduceParts(@parts, "Power Supplies", [])
		session[:part_type] = "Power Supplies"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def memory
	    @parts = Memory.find(:all)
		@parts = reduceParts(@parts, "Memory", [])
		session[:part_type] = "Memory"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def cases
	    @parts = Case.find(:all, :include => :case_motherboards)
		@parts = reduceParts(@parts, "Cases", [])
		session[:part_type] = "Cases"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def displays
	    @parts = Display.find(:all)
		@parts = reduceParts(@parts, "Displays", [])
		session[:part_type] = "Displays"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		@changing = params[:change]
		render :parts
	end
	
	def previous
	    if session[:page_num] > 1
	        session[:page_num] -= 1
		end
		redirect_to :action => :type_determine, :change => params[:changeIt]
	end
	
	def next
	    if session[:page_num] < session[:max]
		    session[:page_num] += 1
		end
		redirect_to :action => :type_determine, :change => params[:changeIt]
	end
	
	def jump
	    session[:page_num] = params[:num].to_i
		redirect_to :action => :type_determine, :change => params[:changeIt]
	end
	
	def type_determine
	    if session[:part_type] == "Motherboards"
			redirect_to :action => :mobos, :change => params[:change]
		elsif session[:part_type] == "Processors"
			redirect_to :action => :cpus, :change => params[:change]
		elsif session[:part_type] == "CPU Coolers"
			redirect_to :action => :coolers, :change => params[:change]
		elsif session[:part_type] == "Disc Drives"
			redirect_to :action => :discs, :change => params[:change]
		elsif session[:part_type] == "Graphics Cards"
			redirect_to :action => :gpus, :change => params[:change]
		elsif session[:part_type] == "Hard Drives"
			redirect_to :action => :hdds, :change => params[:change]
		elsif session[:part_type] == "Power Supplies"
			redirect_to :action => :psus, :change => params[:change]
		elsif session[:part_type] == "Memory"
			redirect_to :action => :memory, :change => params[:change]
		elsif session[:part_type] == "Cases"
			redirect_to :action => :cases, :change => params[:change]
		else
			redirect_to :action => :displays, :change => params[:change]
		end
	end
end
