#For my desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load Memory from csv file into the database"
task :memory => :environment do
    #Line count for error reporting
    count = 0
    begin
        memFile = File.open(Dir.pwd+'/doc/memory_list - Copy.csv', 'r')
	while line = memFile.gets
            count += 1
	    memorySpecs = line.split(',')
	    memory = Memory.new
	    memory.part_id = 1
	    memory.parttype = memorySpecs[0]
	    memory.manufacturer = memorySpecs[1]
	    memory.manufacturerwebsite = memorySpecs[2]
	    memory.price = memorySpecs[3].to_i
	    memory.googleprice = memorySpecs[4]
	    memory.model = memorySpecs[5]
	    if memorySpecs[6] != "nil"
	        memory.series = memorySpecs[6]
	    end
	    memory.speed = memorySpecs[7].to_i
	    memory.timings = memorySpecs[8]
	    memory.capacity = memorySpecs[9].to_i
	    memory.multichanneltype = memorySpecs[10].to_i
	    memory.memorytype = memorySpecs[11]
	    memory.pinnumber = memorySpecs[12].to_i
	    memory.dimms = memorySpecs[13].to_i
	    memory.totalcapacity = memorySpecs[14].to_i
	    memory.voltage = memorySpecs[15].to_f
	    if memory.valid?
                newPart = Part.new
		newPart.parttype = memorySpecs[0]
		newPart.save!
		memory.part_id = newPart.id
		memory.save!
	    else
                #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nMemory at line #{count} is not valid"
		puts memory.errors.full_messages
	    end
	end
	puts "All Memory loaded"
   # rescue
    #    puts "No csv file for Memory"
    end
end
