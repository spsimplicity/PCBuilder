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
		    session[:computer].motherboard = Motherboard.find_by_part_id(params[:id].to_i)
		elsif session[:part_type] == "Processors" 
		    session[:computer].cpu = Cpu.find_by_part_id(params[:id].to_i)
		elsif session[:part_type] == "CPU Coolers" 
		    session[:computer].cpu_cooler = CpuCooler.find_by_part_id(params[:id].to_i)
		elsif session[:part_type] == "Power Supplies"
		    session[:computer].power_supply = PowerSupply.find_by_part_id(params[:id].to_i)
		else
	        session[:computer].has_parts.build(0, params[:id].to_i, session[:part_type])
		end
		redirect_to :controller => :part_categories, :action => :current, :selected => true
	end
    
    def mobos
	    @parts = Motherboard.find(:all)
		if session[:ids]
		    @parts.delete_if {|mobo| session[:ids].include?(mobo.part_id)}
		end
		session[:part_type] = "Motherboards"
		if (@parts.length % 10) == 10
		    session[:max] = @parts.length / 10
		else
		    session[:max] = (@parts.length / 10) + 1
		end
		render :partial =>  "parts_partial"
	end
	
	def cpus
		session[:part_type] = "Processors"
		render :partial =>  "parts_partial"
	end
	
	def coolers
		session[:part_type] = "CPU Coolers"
		render :partial =>  "parts_partial"
	end
	
	def discs
		session[:part_type] = "Disc Drives"
		render :partial =>  "parts_partial"
	end
	
	def gpus
		session[:part_type] = "Graphics Cards"
		render :partial =>  "parts_partial"
	end
	
	def hdds
		session[:part_type] = "Hard Drives"
		render :partial =>  "parts_partial"
	end
	
	def psus
		session[:part_type] = "Power Supplies"
		render :partial =>  "parts_partial"
	end
	
	def memory
		session[:part_type] = "Memory"
		render :partial =>  "parts_partial"
	end
	
	def cases
		session[:part_type] = "Cases"
		render :partial =>  "parts_partial"
	end
	
	def displays
		session[:part_type] = "Monitors"
		render :partial =>  "parts_partial"
	end
	
	def previous
	    if session[:page_num] > 1
	        session[:page_num] -= 1
		end
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
	
	def next
	    if session[:page_num] < session[:max]
		    session[:page_num] += 1
		end
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
	
	def jump
	    session[:page_num] = params[:num].to_i
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
