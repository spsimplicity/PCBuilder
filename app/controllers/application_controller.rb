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
			render :update do |page|
			    page.replace_html 'Nav', :partial => "navigation"
			end
		else
			@up_errors = true
			@sign_errors = @user.errors.full_messages
			render :update do |page|
			    page.replace_html 'Signup', :partial => "signupform"
			end
		end
	end
	
	def existingUser
		@in_errors = false
		@found = true
		@good = true
		@user = User.find_by_name(params[:username])
		if @user == nil
			@in_errors = true
			@found = false
	        render :update do |page|
				page.replace_html 'Signup', :partial => "signupform"
			end
		else
			if @user.has_password?(params[:password])
				session[:user] = @user
				@type = "Log"
				render :update do |page|
					page.replace_html 'Nav', :partial => "navigation"
				end
			else
				@in_errors = true
				@good = false
				render :update do |page|
					page.replace_html 'Signup', :partial => "signupform"
				end
			end
		end
	end
	
	def logout
	    session[:user] = nil
		session[:computer] = nil
		render :update do |page|
			page.replace_html 'Nav', :partial => "navigation"
		end
	end
	
	def remove
	    render :partial => "nothing"
	end
end
