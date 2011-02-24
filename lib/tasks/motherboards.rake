#For my desktop
RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Loads Motherboard data into the database from a csv file."
task :motherboards => :environment do
    #Line count for error reporting
    count = 0
    begin
        moboFile = File.open(Dir.pwd+'/doc/Motherboard_list - Copy.csv', 'r')
	while line = moboFile.gets
	    count = count + 1
	    moboSpecs = line.split(',')
	    mobo = Motherboard.new
	    mobo.part_id = 1
	    mobo.parttype = moboSpecs[0]
	    mobo.manufacturer = moboSpecs[1]
	    mobo.model = moboSpecs[2]
	    mobo.price = moboSpecs[3]
	    mobo.manufacturerwebsite = moboSpecs[4]
	    mobo.googleprice = moboSpecs[5]
	    mobo.maxmemory = moboSpecs[6].to_i
	    mobo.memorytype = moboSpecs[7]
	    mobo.memchannel = moboSpecs[8]
	    mobo.pci_ex16 = moboSpecs[9].to_i
	    mobo.pci_e2 = moboSpecs[10].to_i
	    mobo.size = moboSpecs[11]
	    mobo.memoryslots = moboSpecs[12].to_i
	    mobo.cpupowerpin = moboSpecs[13].to_i
	    mobo.fsb = moboSpecs[14].to_i
	    mobo.northbridge = moboSpecs[15]
	    #assign value to southbridge if tis not nil, otherwise ignore it
	    if moboSpecs[16] != nil
	        mobo.southbridge = moboSpecs[16]
	    end
	    #check if there is a hydra lucid chip
	    if moboSpecs[17] == "TRUE"
	        mobo.hydra = ture
	    else
	        mobo.hydra = false
	    end
	    mobo.mainpower = moboSpecs[18].to_i
	    mobo.pci_e = moboSpecs[19].to_i
	    mobo.pci = moboSpecs[20].to_i
	    #check if mobo is xfire compatible
	    if moboSpecs[21] == "TRUE"
	        mobo.crossfire = true
	    else
                mobo.crossfire = false
	    end
	    #check if mobo is sli compatible
	    if moboSpecs[22] == "TRUE"
	        mobo.sli = true
	    else
	        mobo.sli = false
	    end
	    mobo.sockettype = moboSpecs[23]
	    mobo.sata3 = moboSpecs[25]
	    mobo.sata6 = moboSpecs[26]
	    mobo.ide = moboSpecs[27]
	    if mobo.valid?
	        newPart = Part.new
		newPart.parttype = moboSpecs[0]
		newPart.save!
		mobo.part_id = newPart.id
		mobo.save!
		moboSpecs[24].split('/').each do |speed|
                    moboSpeed = MemorySpeed.new
                    moboSpeed.motherboard_id = mobo.id
		    moboSpeed.speed = speed.to_i
		    if moboSpeed.valid?
		        moboSpeed.save!
		    else
		        #If it is not valid print what line is not valid
			#along with detailed error messages
			puts "\nMotherboard speeds at line #{count} are not valid"
			puts moboSpeed.errors.full_messages
		    end
		end
	    else
	        #If it is not valid print what line is not valid a long with
		#detaild error messages
		puts "\nMotherboard at line #{count} is not valid"
		puts mobo.errors.full_messages
	    end
	end
	puts "All Motherboards loaded"
    #rescue
    #    puts "No csv file for Motherboards"
    end
end
