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
		render :update do |page|
			page.replace_html 'Nav', :partial => "navigation"
		end
	end
	
	def remove
	    render :partial => "nothing"
	end
	
	def remove_part
		session[:ids] = []
		
	    if session[:computer].motherboard_id and (session[:computer].motherboard_id.eql?(params[:part_id].to_i))
		    session[:computer].motherboard_id = nil
		elsif session[:computer].cpu_id and (session[:computer].cpu_id.eql?(params[:part_id].to_i))
		    session[:computer].cpu_id = nil
		elsif session[:computer].cpu_cooler_id and (session[:computer].cpu_cooler_id.eql?(params[:part_id].to_i))
		    session[:computer].cpu_cooler_id = nil
		elsif session[:computer].power_supply_id and (session[:computer].power_supply_id.eql?(params[:part_id].to_i))
		    session[:computer].power_supply_id = nil
		elsif session[:computer].case_id and (session[:computer].case_id.eql?(params[:part_id].to_i))
		    session[:computer].case_id = nil
		else
		    deleted = false
		    spot = 0
		    while !deleted && (spot < session[:computer].has_parts.length)
			    if session[:computer].has_parts[spot].part_id = params[:part_id].to_i
				    session[:computer].has_parts.delete_at(spot)
					deleted = true
				end
				spot += 1
			end
		end
		
	    @reference = request.referer
	    if @reference.include? "part_categories"
	        redirect_to :controller => :part_categories, :action => :current
		elsif @reference.include? "part_selection"
		    render :partial => "selected_tab_ajax"
		else
		    render :fuckinga
		end
	end
	
	def change_part
	    @reference = request.referer
	    if @reference.include?("mobos") && params[:change] == "Motherboards"
			redirect_to :controller => :part_selection, :action => :mobos
		elsif @reference.include?("cpus") && params[:change] == "Processors"
			redirect_to :controller => :part_selection, :action => :cpus
		elsif @reference.include?("coolers") && params[:change] == "CPU_Coolers"
			redirect_to :controller => :part_selection, :action => :coolers
		elsif @reference.include?("discs") && params[:change] == "Disc Drives"
			redirect_to :controller => :part_selection, :action => :discs
		elsif @reference.include?("gpus") && params[:change] == "Graphics Cards"
			redirect_to :controller => :part_selection, :action => :gpus
		elsif @reference.include?("hdds") && params[:change] == "Hard Drives"
			redirect_to :controller => :part_selection, :action => :hdds
		elsif @reference.include?("psus") && params[:change] == "Power Supplies"
			redirect_to :controller => :part_selection, :action => :psus
		elsif @reference.include?("memory") && params[:change] == "Memory"
			redirect_to :controller => :part_selection, :action => :memory
		elsif @reference.include?("cases") && params[:change] == "Cases"
			redirect_to :controller => :part_selection, :action => :cases
		elsif @reference.include?("displays")  && params[:change] == "Displays"
			redirect_to :controller => :part_selection, :action => :displays
		else
	        redirect_to :controller => :part_selection, :action => :init, :part_type => params[:change]
		end
	end
end
