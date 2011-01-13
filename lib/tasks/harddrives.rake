#For my desktop
RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load Hard Drive data from csv file into the database."
task :harddrives => :environment do
    #Line count for error reporting
    count = 0
    begin
        hddFile = File.open(RAILS_ROOT+'/doc/Hard_Drive_List - Copy.csv', 'r')
	while line = hddFile.gets
            count = count + 1
	    hddSpecs = line.split(',')
	    hdd = HardDrife.new
	    hdd.part_id = 1
	    hdd.parttype = hddSpecs[0]
	    hdd.manufacturer = hddSpecs[1]
	    hdd.model = hddSpecs[2]
	    hdd.series = hddSpecs[3]
	    hdd.price = hddSpecs[4].to_i
	    hdd.interface = hddSpecs[5]
	    hdd.capacity = hddSpecs[6].to_i
	    hdd.rpm = hddSpecs[7].to_i
	    if hddSpecs[8] != "nil"
	        hdd.cache = hddSpecs[8].to_i
	    end
	    hdd.manufacturerwebsite = hddSpecs[9]
	    hdd.googleprice = hddSpecs[10]
	    if hdd.valid?
                newPart = Part.new
		newPart.parttype = hddSpecs[0]
		newPart.save!
		hdd.part_id = newPart.id
		hdd.save!
	    else
                #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nHard Drive at line #{count} is not valid"
		puts hdd.errors.full_messages
	    end
	end
	puts "All Hard Drives loaded"
    rescue
        puts "No csv file for Hard Drives"
    end
end
