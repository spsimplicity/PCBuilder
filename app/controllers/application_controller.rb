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
			redirect_to :controller => :application, :action => :loadIn
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
				#session[:user].getLastThree(Computer.find_all_by_user_id(session[:user].id, :order => 'updated_at DESC'))
				redirect_to :controller => :application, :action => :loadIn
			else
				@in_errors = true
				@good = false
				render :update do |page|
					page.replace_html 'Signup', :partial => "signupform"
				end
			end
		end
	end
	
	def loadIn
		render :update do |page|
			page.replace_html 'Nav', :partial => "navigation"
			if request.referer.include?("part_categories")
				page.replace_html 'Main', :partial => "categories_partial"
			else
			    page.replace_html 'Main', :partial => "parts_partial"
			end
		end
	end
	
	def logout
	    session[:user] = nil
		session[:computer].user_id = nil
		redirect_to :controller => :application, :action => :loadIn
	end
	
	def remove
	    render :partial => "nothing"
	end
	
	def remove_part
	    if session[:computer].motherboard_id and (session[:computer].motherboard_id.eql?(params[:part_id].to_i))
		    session[:computer].price -= Motherboard.find_by_part_id(session[:computer].motherboard_id).price
		    session[:computer].motherboard_id = nil
		elsif session[:computer].cpu_id and (session[:computer].cpu_id.eql?(params[:part_id].to_i))
		    session[:computer].price -= Cpu.find_by_part_id(session[:computer].cpu_id).price
		    session[:computer].cpu_id = nil
		elsif session[:computer].cpu_cooler_id and (session[:computer].cpu_cooler_id.eql?(params[:part_id].to_i))
		    session[:computer].price -= CpuCooler.find_by_part_id(session[:computer].cpu_cooler_id).price
		    session[:computer].cpu_cooler_id = nil
		elsif session[:computer].power_supply_id and (session[:computer].power_supply_id.eql?(params[:part_id].to_i))
		    session[:computer].price -= PowerSupply.find_by_part_id(session[:computer].power_supply_id).price
		    session[:computer].power_supply_id = nil
		elsif session[:computer].case_id and (session[:computer].case_id.eql?(params[:part_id].to_i))
		    session[:computer].price -= Case.find_by_part_id(session[:computer].case_id).price
		    session[:computer].case_id = nil
		else
		    deleted = false
		    spot = 0
		    while(spot < session[:computer].other_parts.length && !deleted)
			    if session[:computer].other_parts[spot][0] = params[:part_id].to_i
				    if session[:computer].other_parts[spot][1] == "Graphics Card"
					    session[:computer].price -= GraphicsCard.find_by_part_id(params[:part_id].to_i).price
					elsif session[:computer].other_parts[spot][1] == "Hard Drive"
					    session[:computer].price -= HardDrife.find_by_part_id(params[:part_id].to_i).price
					elsif session[:computer].other_parts[spot][1] == "Disc Drive"
					    session[:computer].price -= DiscDrife.find_by_part_id(params[:part_id].to_i).price
					elsif session[:computer].other_parts[spot][1] == "Memory"
					    session[:computer].price -= Memory.find_by_part_id(params[:part_id].to_i).price
					else
					    session[:computer].price -= Display.find_by_part_id(params[:part_id].to_i).price
					end
				    session[:computer].other_parts.delete_at(spot)
					deleted = true
				end
				spot += 1
			end
		end
		
	    @reference = request.referer
	    if @reference.include? "part_categories"
	        redirect_to :controller => :part_categories, :action => :current
		elsif @reference.include? "part_selection"
		    render :partial => "selected_tab_ajax", :locals => {
				:comp_mobo => Motherboard.find_by_part_id(session[:computer].motherboard_id),
				:comp_cpu => Cpu.find_by_part_id(session[:computer].cpu_id),
				:comp_cooler => CpuCooler.find_by_part_id(session[:computer].cpu_cooler_id),
				:comp_case => Case.find_by_part_id(session[:computer].case_id),
				:comp_power => PowerSupply.find_by_part_id(session[:computer].power_supply_id)
			}
		else
		    render :howdidyougethere
		end
	end
	
	def change_part
	    @reference = request.referer
	    if params[:change] == "Motherboards"
			redirect_to :controller => :part_selection, :action => :mobos, :change => params[:part_id]
		elsif params[:change] == "Processors"
			redirect_to :controller => :part_selection, :action => :cpus, :change => params[:part_id]
		elsif params[:change] == "CPU_Coolers"
			redirect_to :controller => :part_selection, :action => :coolers, :change => params[:part_id]
		elsif params[:change] == "Disc Drives"
			redirect_to :controller => :part_selection, :action => :discs, :change => params[:part_id]
		elsif params[:change] == "Graphics Cards"
			redirect_to :controller => :part_selection, :action => :gpus, :change => params[:part_id]
		elsif params[:change] == "Hard Drives"
			redirect_to :controller => :part_selection, :action => :hdds, :change => params[:part_id]
		elsif params[:change] == "Power Supplies"
			redirect_to :controller => :part_selection, :action => :psus, :change => params[:part_id]
		elsif params[:change] == "Memory"
			redirect_to :controller => :part_selection, :action => :memory, :change => params[:part_id]
		elsif params[:change] == "Cases"
			redirect_to :controller => :part_selection, :action => :cases, :change => params[:part_id]
		elsif params[:change] == "Displays"
			redirect_to :controller => :part_selection, :action => :displays, :change => params[:part_id]
		else
	        redirect_to :controller => :part_selection, :action => :init, :part_type => params[:change], :change => params[:part_id]
		end
	end
end
