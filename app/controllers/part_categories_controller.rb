class PartCategoriesController < ApplicationController
    def login
	    @user
	end
	
	def logout
	    session[:user] = nil
		redirect_to_request.referer
	end
	
	def loadbuild
	    @build
	end
	
	def savebuild
	end
	
	def constraints
	end
end