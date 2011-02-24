#For my desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load CPU Cooler data from csv files into the database"
task :coolers => :environment do
    #Line count for error reporting
    count = 0
    begin
        #Open CPU Cooler csv file
	coolerFile = File.open(Dir.pwd+'/doc/cpu_cooler_list - Copy.csv', 'r')
	while line = coolerFile.gets
            count = count + 1
	    coolerSpecs = line.split(',')
	    cooler = CpuCooler.new
	    cooler.part_id = 1
	    cooler.parttype = coolerSpecs[0]
	    cooler.manufacturer = coolerSpecs[1]
	    cooler.manufacturerwebsite = coolerSpecs[2]
	    cooler.price = coolerSpecs[3].to_i
	    cooler.googleprice = coolerSpecs[4]
	    cooler.model = coolerSpecs[5]
	    #Assign number to maxmemheight if its not nil, otherwise ignore it
	    if coolerSpecs[6] != "nil"
	        cooler.maxmemheight = coolerSpecs[6].to_i
	    end
	    cooler.height = coolerSpecs[7].to_i
	    cooler.width = coolerSpecs[8].to_i
	    cooler.length = coolerSpecs[9].to_i
	    #If its valid create a new part to go with the new cpu cooler
	    if cooler.valid?
                part = Part.new
		part.parttype = coolerSpecs[0]
		part.save!
		cooler.part_id = part.id
		cooler.save!
		#Make a new cpu cooler socket for each socket the cooler is
		#compatible with
		coolerSpecs[10].split(' ').each do |socket|
                    coolerSocket = CpuCoolerSocket.new
		    coolerSocket.cpu_cooler_id = cooler.id
		    coolerSocket.sockettype = socket
		    if coolerSocket.valid?
		        coolerSocket.save!
		    else
                        #If it is not valid print what line is not valid
			#along with detailed error messages
			puts "\nSockets at line #{count} are not valid"
			pus coolerSocket.errors.full_messages
		    end
		end
	    else
	        #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nCooler at line #{count} is not valid"
		puts cooler.errors.full_messages
	    end
	end
        puts "All CPU Coolers loaded"
    rescue
        puts "No csv file for CPU Coolers"
    end
end
