#For my desktop
RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Loads Monitor data from a csv file into the database."
task :monitors => :environment do
    #Line count for error reporting
    count = 0
    begin
        monitorFile = File.open(RAILS_ROOT+'/doc/monitor_list - Copy.csv', 'r')
	while line = monitorFile.gets
            count = count + 1
	    monitorSpecs = line.split(',')
	    monitor = Display.new
	    monitor.part_id = 1
	    monitor.parttype = monitorSpecs[0]
	    monitor.manufacturer = monitorSpecs[1]
	    monitor.manufacturerwebsite = monitorSpecs[2]
	    monitor.price = monitorSpecs[3].to_i
	    monitor.googleprice = monitorSpecs[4]
	    monitor.model = monitorSpecs[5]
	    monitor.contrastratio = monitorSpecs[6]
	    if monitorSpecs[7] != "nil"
	        monitor.length = monitorSpecs[7].to_i
	    end
	    if monitorSpecs[8] != "nil"
                monitor.width = monitorSpecs[8].to_i
	    end
	    if monitorSpecs[9] != "nil"
	        monitor.height = monitorSpecs[9].to_i 
	    end
	    monitor.resolution = monitorSpecs[10]
	    monitor.monitortype = monitorSpecs[11]
	    monitor.screensize = monitorSpecs[12].to_i
	    if monitorSpecs[13] == "true"
	        monitor.widescreen = true
	    else
	        monitor.widescreen = false
	    end
	    if monitorSpecs[14] != "nil"
	        monitor.displaycolors = monitorSpecs[14].to_f
	    end
	    monitor.vga = monitorSpecs[15].to_i
	    monitor.hdmi = monitorSpecs[16].to_i
	    monitor.svideo = monitorSpecs[17].to_i
	    monitor.dvi = monitorSpecs[18].to_i
	    monitor.displayport = monitorSpecs[19].to_i
	    if monitor.valid?
                part = Part.new
		part.parttype = monitorSpecs[0]
		part.save!
		monitor.part_id = part.id
		monitor.save!
	    else
                #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nMonitor at line #{count} is not valid"
		puts monitor.errors.full_messages
	    end
	end
	puts "All Monitors loaded"
    rescue
        puts "No csv file for Monitors"
    end
end
