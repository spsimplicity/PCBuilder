class PartCategoriesController < ApplicationController
    	
	def newBuild
	    if flash[:in_errors] == "found"
	        @errors = true
			@found = false
		elsif flash[:in_errors] == "good"
		    @errors = true
			@good = false
		end
	    render :categories
		if session[:user]
		    @comps = Computer.find_by_user_id(session[:user].id)
		end
	    session[:new_computer] = Computer.new
	end
	
	def existingBuild
	    session[:new_computer] = Computer.find_by_name(params[:existing])
	end
	
	def login
	end
	
	def logout
	    session[:user] = nil
		redirect_to :action => :newBuild
	end
	
	def loadbuild
	    @build
	end
	
	def savebuild
	end
	
	def constraints
	end
end
