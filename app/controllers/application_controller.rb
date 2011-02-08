# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    protect_from_forgery # See ActionController::RequestForgeryProtection for details

    filter_parameter_logging :password    
	
	def showform
	    render :partial => "signupform", :locals => {:login_errors => false}
	end
	
	def newUser
	    @up_errors = false
		@user = User.new
		@user.name = params[:username]
		@user.password = params[:password]
		@user.password_confirmation = params[:password]
		@user.email = params[:email]
		@user.ip = request.remote_ip
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
	
	def existingUser
		@in_errors = false
		@user = User.find_by_name(params[:username])
		if @user == nil
			@in_errors = true
			@found = false
			flash[:in_errors] = "found"
	        redirect_to :action => :login
		else
			if @user.has_password?(params[:password])
				session[:user] = @user
				@type = "Log"
				redirect_to root_path
			else
				@in_errors = true
				@good = false
			    flash[:in_errors] = "good"
				redirect_to :action => :login
			end
		end
	end
	
	def login
	    if flash[:in_errors] == "found"
	        @errors = true
			@found = false
		elsif flash[:in_errors] == "good"
		    @errors = true
			@good = false
		end
	    render :categories
	end
	
	def logout
	    session[:user] = nil
		redirect_to root_path
	end
	
	def remove
	    render :partial => "nothing"
	end
end
