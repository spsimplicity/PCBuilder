class PartCategoriesController < ApplicationController
    
	def index
	    if params[:in_errors]
	        @errors = params[:in_errors]
		end
	    render :categories
		if session[:user]
		    @comps = Computer.find_by_user_id(session[:user].id)
		end
	end
	
	def login
	end
	
	def logout
	    session[:user] = nil
		redirect_to :action => :index
	end
	
	def loadbuild
	    @build
	end
	
	def savebuild
	end
	
	def constraints
	end
end
