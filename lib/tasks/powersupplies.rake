#For my Desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Loads Power Supply data from a csv file into the database."
task :powersupplies => :environment do
    #Line count for error reporting
    count = 0
    begin
        #Open Power Supply csv file
        powerFile = File.open(RAILS_ROOT+'/doc/Power_Supply_list - Copy.csv', 'r')
	while line = powerFile.gets
            count = count + 1
	    psuSpecs = line.split(',')
	    psu = PowerSupply.new
	    psu.part_id = 1
            psu.parttype = psuSpecs[0]
	    psu.manufacturer = psuSpecs[1]
	    psu.manufacturerwebsite = psuSpecs[2]
	    psu.googleprice = psuSpecs[3]
	    psu.price = psuSpecs[4].to_i
	    psu.model = psuSpecs[5]
	    psu.series = psuSpecs[6]
	    psu.fansize = psuSpecs[7].to_i
	    psu.mainpower = psuSpecs[8].to_i
	    psu.satapower = psuSpecs[9].to_i
	    if psuSpecs[10] == "TRUE"
	        psu.multi_gpu = true
	    else
	        psu.multi_gpu = false
	    end
	    psu.peripheral = psuSpecs[11].to_i
	    if psuSpecs[12] != "nil"
	        psu.energycert = psuSpecs[12]
	    end
	    psu.power_supply_type = psuSpecs[13]
	    psu.poweroutput = psuSpecs[14].to_i
	    psu.cpu4_4pin = psuSpecs[15].to_i
	    psu.cpu4pin = psuSpecs[16].to_i
	    psu.cpu8pin = psuSpecs[17].to_i
	    psu.gpu8pin = psuSpecs[18].to_i
	    psu.gpu6pin = psuSpecs[19].to_i
	    psu.gpu6_2pin = psuSpecs[20].to_i
	    psu.length = psuSpecs[21].to_i
	    if psu.valid?
	        newPart = Part.new
		newPart.parttype = psuSpecs[0]
		newPart.save!
		psu.part_id = newPart.id
		psu.save!
	    else
                #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nPower Supply at line #{count} is not valid"
		puts psu.errors.full_messages
	    end
	end
	puts "All Power Supplies Loaded"
    rescue
        puts "No csv file for Power Supplies"
    end
end
