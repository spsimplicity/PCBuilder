#For my desktop
RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load CPU data from csv file into the database."
task :cpus => :environment do
    #Line count for error reporting
    count = 0
    begin
        cpuFile = File.open(RAILS_ROOT+'/doc/CPU_list - Copy.csv', 'r')
	while line = cpuFile.gets
            count = count + 1
	    cpuSpecs = line.split(',')
	    cpu = Cpu.new
	    cpu.part_id = 1
	    cpu.parttype = cpuSpecs[0]
	    cpu.model = cpuSpecs[1]
	    cpu.series = cpuSpecs[2]
	    cpu.manufacturer = cpuSpecs[3]
	    cpu.price = cpuSpecs[4].to_i
	    cpu.manufacturerwebsite = cpuSpecs[5]
	    cpu.googleprice = cpuSpecs[6]
	    cpu.frequency = cpuSpecs[7].to_f
	    cpu.sockettype = cpuSpecs[8]
	    cpu.fsb = cpuSpecs[9].to_f
	    cpu.l1cache = cpuSpecs[10].to_i
	    cpu.l2cache = cpuSpecs[11].to_i
	    cpu.l3cache = cpuSpecs[12].to_i
	    cpu.cores = cpuSpecs[13].to_i
	    cpu.watts = cpuSpecs[14].to_i
	    cpu.powerpin = cpuSpecs[15].to_i
	    if cpuSpecs[16] != "nil"
	        cpu.maxmemory = cpuSpecs[16].to_i
	    end
	    if cpuSpecs[17] != "nil"
	        cpu.memchanneltype = cpuSpecs[17].to_i
	    end
	    if cpu.valid?
                part = Part.new
		part.parttype = cpuSpecs[0]
		part.save!
		cpu.part_id = part.id
		cpu.save!
	    else
	        #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nCPU at line #{count} is not valid"
		puts cpu.errors.full_messages
	    end
	end
	puts "All CPUs loaded"
    rescue
        puts "No csv file for CPUs"
    end
end
