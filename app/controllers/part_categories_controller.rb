class PartCategoriesController < ApplicationController
    
	def current
	    puts session[:computer].motherboard
	    render :partial => "categories_partial"
	end
	
	def newBuild
	    session[:computer] = Computer.new
		session[:ids] = nil
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
	
	def loadbuild
	    @build
	end
	
	def savebuild
	end
	
	def constraints
	end
end
