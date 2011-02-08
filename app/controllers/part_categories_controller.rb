class PartCategoriesController < ApplicationController
    	
	def newBuild
	    render :categories
		if session[:user]
		    @comps = Computer.find_by_user_id(session[:user].id)
		end
	    session[:new_computer] = Computer.new
	end
	
	def existingBuild
	    session[:new_computer] = Computer.find_by_name(params[:existing])
	end
	
	def logout
	end
	
	def loadbuild
	    @build
	end
	
	def savebuild
	end
	
	def constraints
	end
end
