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
	    render :categories
	end
	
	def newBuild
	    session[:computer] = Computer.new
		session[:computer].other_parts = []
	    render :categories
	end
	
	def existingBuild
	    render :categories
	    session[:computer] = Computer.find_by_name_and_user_id(params[:existing], session[:user].id, :include => :has_parts)		
	end
	
	def savebuild
	end
end
