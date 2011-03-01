#For my desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load Disc Drive data from csv file into the database"
task :discdrives => :environment do
    #Line count for error reporting
    count = 0
    begin
        ddFile = File.open(Dir.pwd+'/doc/Disc_Drive_list.csv', 'r')
	while line = ddFile.gets
	    count = count + 1
	    discdSpecs = line.split(',')
	    discd = DiscDrife.new
	    discd.part_id = 1
	    discd.parttype = discdSpecs[0]
	    discd.manufacturer = discdSpecs[1]
	    discd.manufacturerwebsite = discdSpecs[2]
	    discd.price = discdSpecs[3]
	    discd.googleprice = discdSpecs[4]
	    discd.model = discdSpecs[5]
	    discd.interface = discdSpecs[6]
	    discd.cache = discdSpecs[7]
	    discd.drivetype = discdSpecs[8]
	    if discd.valid?
                part = Part.new
		part.parttype = discdSpecs[0]
		part.save!
		discd.part_id = part.id
		discd.save!
		#Drive speed should be like this: rw 24/w 30 and so on
		discdSpecs[9].split('/').each do |readSpeed|
                    newSpeed = readSpeed.split(' ')
		    speed = ReadSpeed.new
		    speed.disc_drife_id = discd.id
		    speed.readtype = newSpeed[0]
		    speed.speed = newSpeed[1]
		    if speed.valid?
		        speed.save!
		    else
		        #If it is not valid print what line is not valid 
			#along with detailed error messages
			puts "\nRead Speeds at line #{count} are not valid"
			puts speed.errors.full_messages
		    end
		end
		discdSpecs[10].split('/').each do |writeSpeed|
                    newSpeed = writeSpeed.split(' ')
		    speed = WriteSpeed.new
		    speed.disc_drife_id = discd.id
		    speed.writetype = newSpeed[0]
		    speed.speed = newSpeed[1]
		    if speed.valid?
		        speed.save!
		    else
                        #If it is not valid print what line is not valid
			#along with detailed error messages
			puts "\nWrite Speeds at line #{count} are not valid"
			puts speed.errors.full_messages
		    end
		end
	    else
                #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nDisc Drive at line #{count} is not valid"
		puts discd.errors.full_messages
	    end
	end
    rescue
        puts "No csv file for Disc Drives"
    end
end
