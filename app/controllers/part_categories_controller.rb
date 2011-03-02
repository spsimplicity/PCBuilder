class PartCategoriesController < ApplicationController
    
	def current
	    @gpu = false
		@mon = false
		@dd = false
		@hdd = false
		@mem = false
	    session[:computer].other_parts.each do |part|
		    if part[1].eql?"Graphics Card"
	            @gpu = true
			elsif part[1].eql?"Hard Drive"
	            @hdd = true
			elsif part[1].eql?"Display"
	            @mon = true
			elsif part[1].eql?"Disc Drive"
	            @dd = true
			else
	            @mem = true
			end
		end
		session[:price] = session[:computer].getPrice
		session[:user].getLastThree(Computer.find_all_by_user_id(session[:user].id, :order => 'updated_at DESC'))
	    render :categories
	end
	
	def newBuild
	    session[:computer] = Computer.new
		session[:computer].price = 0
		session[:computer].other_parts = []
		if session[:user]
		    session[:computer].user_id = session[:user].id
		end
		session[:user].getLastThree(Computer.find_all_by_user_id(session[:user].id, :order => 'updated_at DESC'))
	    render :categories
	end
	
	def existingBuild
	    render :categories
	    session[:computer] = Computer.find_by_name(params[:existing])		
		session[:computer].has_parts.each do |part|
		    session[:ids].push(part.part_id)
		end
	end
	
	def saveBuild
	    session[:computer].name = params[:saving]
	    computer = session[:computer]
		if !computer.id && computer.valid?
		    computer.save!
		end
		session[:computer].id = computer.id
		computer.other_parts.each do |part|
		    alreadyHas = false
		    HasPart.find_all_by_computer_id(computer.id).each do |hp|
			    if hp.part_id == part[0]
				    alreadyHas = true
				end
			end
			if !alreadyHas
		        computer.has_parts.build(:computer_id => computer.id, :part_id => part[0], :parttype => part[1])
			end
		end
		computer.save!
		session[:user].getLastThree(Computer.find_all_by_user_id(session[:user].id, :order => 'updated_at DESC'))
		redirect_to request.referer
	end
end
