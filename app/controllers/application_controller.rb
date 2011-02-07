# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    protect_from_forgery # See ActionController::RequestForgeryProtection for details

    filter_parameter_logging :password    
	
	def showform
	    render :partial => "signupform"
	end
	
	def new
	    @up_errors = false
		@user = User.new
		@user.name = params[:username]
		@user.password = params[:password]
		@user.password_confirmation = params[:password]
		@user.email = params[:email]
		@user.ip = "103.103.1.1"
		if(@user.valid?)
			@user.save!
			session[:user] = @user
			@type = "Sign"
			render :partial => "success"
		else
			@up_errors = true
			@sign_errors = @user.errors.full_messages
			render :partial => "signupform"
		end
	end
	
	def existing
		@in_errors = false
		@user = User.find_by_name(params[:username])
		if @user == nil
			@in_errors = true
			@found = false
	        redirect_to :controller => :part_categories, :action => :index, :in_errors => {"errors", true, "found", false, "good", true}
		else
			if @user.has_password?(params[:password])
				session[:user] = @user
				@type = "Log"
				redirect_to :controller => :part_categories, :action => :index
			else
				@in_errors = true
				@good = false
				redirect_to :controller => :part_categories, :action => :index, :in_errors => {"errors", true, "found", true, "good", false}
			end
		end
	end
	
	def remove
	    render :partial => "nothing"
	end
end
