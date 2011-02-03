# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    protect_from_forgery # See ActionController::RequestForgeryProtection for details

    # Scrub sensitive parameters from your log
    # filter_parameter_logging :password    
	
	def showform
	    render :partial => "signupform"
	end
	
	def new
	    @user = User.new
		@user.name = :username
		@user.password = :password
		@user.email = :email
		@user.ip = "103.103.1.1"
		if(@user.valid?)
		    @user.save!
		    session[:user] = @user
	        render :partial => "nothing"
			redirect_to :controller => :part_categories, :action => 'index'
		else
		    render :partial => "signupform"
		end
	end
	
	def remove
	    render :partial => "nothing"
	end
end
