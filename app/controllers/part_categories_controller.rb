class PartCategoriesController < ApplicationController
    
	def current
	    @gpu = false
		@mon = false
		@dd = false
		@hdd = false
		@mem = false
	    session[:computer].other_parts.each do |part|
		    if part[1].eql?"Graphics Card"
	            @gpu = true
			elsif part[1].eql?"Hard Drive"
	            @hdd = true
			elsif part[1].eql?"Display"
	            @mon = true
			elsif part[1].eql?"Disc Drive"
	            @dd = true
			else
	            @mem = true
			end
		end
		session[:price] = session[:computer].getPrice
	    render :categories
	end
	
	def newBuild
	    session[:computer] = Computer.new
		session[:computer].price = 0
		session[:computer].other_parts = []
	    render :categories
	end
	
	def existingBuild
	    render :categories
	    session[:computer] = Computer.find_by_name(params[:existing], :include => :has_parts)
		session[:ids] = session[:computer].getIds
		session[:computer].has_parts.each do |part|
		    session[:ids].push(part.part_id)
		end
	end
	
	def savebuild
	    session[:computer].name = params[:saving]
	    computer = session[:computer]
		computer.other_parts.each do |part|
		    computer.has_parts.build(HasPart.new())
		end
	end
end
