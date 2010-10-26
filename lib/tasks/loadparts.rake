RAILS_ROOT = 'E:/Users/simplicity/rails_projects/PCBuilder'

#Due to a shitty bug or something I did on accident I cant do the standard
#CpuCooler.new(:part_id => 1 ... and so on). I have no idea what I did or
#why it wont work, everything just gets set to nil. So I am forced to assign
#values as such

namespace :db do
    desc "Create a fake part for initial creation of parts"
	task :fake => :environment do
		#Fake first part to allow validation
		partFake = Part.new
		partFake.parttype = "FAKE"
		partFake.save!
	end

    desc "Load Motherboards"
	task :motherboards => :environment do
	    #Line count for error reporting
	    count = 0	
		begin
			File.open(RAILS_ROOT+'/doc/Motherboard_list.csv', 'r') do |file|
				#get each line in the file
				while line = file.gets
					count = count + 1
					moboSpecs = line.split(',')
					mobo = Motherboard.new
					mobo.part_id = 1
					mobo.parttype = moboSpecs[0]
					mobo.manufacturer = moboSpecs[1]
					mobo.model = moboSpecs[2]
					mobo.price = moboSpecs[3].to_i
					mobo.manufacturerwebsite = moboSpecs[4]
					mobo.googleprice = moboSpecs[5]
					mobo.maxmemory = moboSpecs[6].to_i
					mobo.memorytype  = moboSpecs[7]
					mobo.memchannel = moboSpecs[8]
					mobo.pci_ex16 = moboSpecs[9].to_i
					mobo.pci_e2 = moboSpecs[10].to_i
					mobo.memoryslots = moboSpecs[12].to_i
					mobo.size = moboSpecs[11]
					mobo.cpupowerpin = moboSpecs[13].to_i
					mobo.fsb = moboSpecs[14].to_i
					mobo.northbridge = moboSpecs[15]				
					#assign value to southbridge if its not nil otherwise ignore it
					if moboSpecs[16] != nil
						mobo.southbridge = moboSpecs[16]
					end
					mobo.mainpower = moboSpecs[17].to_i
					mobo.pci_e = moboSpecs[18].to_i
					mobo.pci = moboSpecs[19].to_i
					#wish strings had a .to_bool method
					if moboSpecs[20] == "TRUE"
						mobo.crossfire = true
					else
						mobo.crossfire = false
					end
					if moboSpecs[21] == "TRUE"
						mobo.sli = true
					else
						mobo.sli = false
					end
					mobo.sockettype = moboSpecs[22]
					mobo.sata3 = moboSpecs[24]
					mobo.sata6 = moboSpecs[25]
					mobo.ide = moboSpecs[26]
					if mobo.valid?
						newPart = Part.new
						newPart.parttype = moboSpecs[0]
						newPart.save!
						mobo.part_id = newPart.id
						mobo.save!
						speeds = moboSpecs[23].split('/')
						speeds.each do |speed|
							moboSpeed = MemorySpeed.new
							moboSpeed.motherboard_id = mobo.id
							moboSpeed.speed = speed.to_i
							if moboSpeed.valid?
								moboSpeed.save!
							end
						end
					else
						#If it is not valid print what line is not valid along with
						#detailed error messages
						puts "\nMotherboard at line #{count} is not valid"
						puts mobo.errors.full_messages
					end
				end
			end
			puts "All Motherboards loaded"
		rescue Exception
		    puts "No csv file for Motherboards"
		end
	end
	
	desc "Load Power Supplies"
	task :powersupplies => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Power_Supply_list csv file
			File.open(RAILS_ROOT + '/doc/Power_Supply_list.csv', 'r') do |file|
				while line = file.gets
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
					if psuSpecs[10] == "Yes"
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
						puts "\nPsu at line #{count} is not valid"
						puts psu.errors.full_messages
					end
				end
			end
			puts "All Power Supplies loaded"
		rescue Exception
		    puts "No csv file for Power Supplies"
		end
	end
	
	desc "Load Cases"
	task :cases => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Case_list csv file
			File.open(RAILS_ROOT + '/doc/Case_list.csv', 'r') do |file|
				while line = file.gets
					count = count + 1
					caseSpecs = line.split(',')
					compCase = Case.new
					compCase.part_id = 1
					compCase.parttype = caseSpecs[0]
					compCase.manufacturer = caseSpecs[1]
					compCase.price = caseSpecs[2].to_i
					compCase.model = caseSpecs[3]
					compCase.series = caseSpecs[4]
					compCase.manufacturerwebsite = caseSpecs[5]
					compCase.googleprice = caseSpecs[6]
					compCase.totalbays = caseSpecs[7].to_i
					compCase.hddbays = caseSpecs[8].to_i
					compCase.conversionbays = caseSpecs[9].to_i
					compCase.ssdbays = caseSpecs[10].to_i
					compCase.expansionslots = caseSpecs[11].to_i
					compCase.discbays = caseSpecs[12].to_i
					compCase.casetype = caseSpecs[13]
					compCase.length = caseSpecs[14].to_i
					compCase.width = caseSpecs[15].to_i
					compCase.height = caseSpecs[16].to_i
					compCase.maxcoolerheight = caseSpecs[17].to_i
					if compCase.valid?
					    newPart = Part.new
						newPart.parttype = caseSpecs[0]
						compCase.part_id = newPart.id
						compCase.save!
						sizes = caseSpecs[18].split('/')						
						#Make a new case_motherboard for each mobo size the case is
						#compatible with
						size.each do |size|
						    caseMobo = CaseMotherboard.new
							caseMobo.case_id = compCase.id
							caseMobo.size = size
							if caseMobo.valid?
							    caseMobo.save!
							end
						end
					else
					    #If it is not valid print what line is not valid along with
						#detailed error messages
						puts "\nCase at line #{count} is not valid"
						puts compCase.errors.full_messages
					end
				end
			end
			puts "All Cases loaded"
		rescue Exception
		    puts "No csv file for Cases"
		end
	end
	
	desc "Load CPU Coolers"
	task :coolers => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open cpu_cooler_list csv file
			File.open(RAILS_ROOT+'/doc/cpu_cooler_list - Copy.csv', 'r') do |file|
				#get each line in the file
				while line = file.gets
					count = count + 1
					#Turn line into an array where each element is ended by a comma
					coolerSpecs = line.split(',')
					#Create new CpuCooler and assign values
					cooler = CpuCooler.new
					cooler.part_id = 1
					cooler.parttype = coolerSpecs[0]
					cooler.model = coolerSpecs[5]
					cooler.manufacturer = coolerSpecs[1]
					cooler.manufacturerwebsite = coolerSpecs[2]
					cooler.price = coolerSpecs[3].to_i
					cooler.googleprice = coolerSpecs[4]
					#assign number to maxmemheight if its not nil otherwise ignore it
					if coolerSpecs[6] != "nil"
						cooler.maxmemheight = coolerSpecs[6].to_i
					end
					cooler.height = coolerSpecs[7].to_f
					cooler.width = coolerSpecs[8].to_f
					cooler.length = coolerSpecs[9].to_f
					#If its valid create a new part to go with the new cpu cooler
					if cooler.valid?
						part = Part.new
						part.parttype = coolerSpecs[0]
						part.save!
						cooler.part_id = part.id
						cooler.save!
						sockets = coolerSpecs[10].split(' ')
						#Make a new cpu_cooler_socket for each socket the cooler is
						#compatible with
						sockets.each do |socket|
							coolerSocket = CpuCoolerSocket.new
							coolerSocket.cpu_cooler_id = cooler.id
							coolerSocket.sockettype = socket
							if coolerSocket.valid?
								coolerSocket.save!
							end
						end
					else
						#If it is not valid print what line is not valid along with
						#detailed error messages
						puts "\nCooler at line #{count} is not valid"
						puts cooler.errors.full_messages
					end
				end
			end
			puts "All CPU Coolers loaded"
		rescue Exception
		    puts "No csv file for CPU Coolers"
		end
	end
	
	desc "Load CPUs"
	task :cpus => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open cpu_list csv file
			File.open(RAILS_ROOT + '/doc/CPU_list - Copy.csv', 'r') do |file|
				while line = file.gets
					count = count + 1
					cpuSpecs = line.split(',')
					cpu = Cpu.new
					cpu.part_id = 1
					cpu.parttype = cpuSpecs[0]
					cpu.model = cpuSpecs[1]
					cpu.manufacturer = cpuSpecs[3]
					cpu.series = cpuSpecs[2]
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
					if  cpuSpecs[16] != "nil"
						cpu.maxmemory  = cpuSpecs[16].to_i
					end
					if cpuSpecs[17] != "nil"
						cpu.memchanneltype  = cpuSpecs[17].to_i
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
			end
			puts "All CPUs loaded"
		rescue Exception
		    puts "No csv file for CPUs"
		end
	end
	
	desc "Load Monitors"
	task :monitors => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Monitors_list csv file
			File.open(RAILS_ROOT + '/doc/Monitors_list.csv', 'r') do |file|
				while line = file.gets
					count = count + 1
					monitorSpecs = line.split(',')
					monitor = Monitor.new
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
			end
			puts "All Monitors loaded"
		rescue Exception
		    puts "No csv file for Monitors"
		end
	end
	
	desc "Load Disc Drives"
	task :discdrives => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Disc_Drive_list csv file
			File.open(RAILS_ROOT + '/doc/Disc_Drive_list.csv', 'r') do |file|
				while line = file.gets
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
						#Drive speed should be like this:
						#rw 24 / w 30 and so on
						discdSpecs[9].split('/').each do |readSpeed|
						    newSpeed = readSpeed.split(' ')
							speed = ReadSpeed.new
							speed.disc_drife_id = discd.id
							speed.readtype = newSpeed[0]
							speed.speed = newSpeed[1]
							speed.save!
						end
						discdSpecs[10].split('/').each do |writeSpeed|
						    newSpeed = writeSpeed.split(' ')
							speed = WriteSpeed.new
							speed.disc_drife_id = discd.id
							speed.writetype = newSpeed[0]
							speed.speed = newSpeed[1]
							speed.save!
						end
					else
						#If it is not valid print what line is not valid along with
						#detailed error messages
						puts "\nDisc Drive at line #{count} is not valid"
						puts discd.errors.full_messages
					end
				end
			end
			puts "All Disc Drives loaded"
		rescue Exception
		    puts "No csv file for Disc Drives"
		end
	end
	
	desc "Load Hard Drives"
	task :harddrives => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Hard_Drive_list csv file
			File.open(RAILS_ROOT + '/doc/Hard_Drive_list.csv', 'r') do |file|
				while line = file.gets
					count = count + 1
					hddSpecs = line.split(',')
					hdd = HardDrife.new
					hdd.part_id = 1
					hdd.parttype = hddSpecs[0]
					hdd.manufacturer = hddSpecs[1]
					hdd.manufacturerwebsite = hddSpecs[9]
					hdd.googleprice = hddSpecs[10]
					hdd.model = hddSpecs[2]
					hdd.series = hddSpecs[3]
					hdd.price = hddSpecs[4].to_i
					hdd.interface = hddSpecs[5]
					hdd.capacity = hddSpecs[6].to_i
					hdd.rpm = hddSpecs[7].to_i
					if hddSpecs[8] != "nil"
					    hdd.cache = hddSpecs[8].to_i
					end
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
			end
			puts "All Hard Drives loaded"
		rescue Exception
		    puts "No csv file for Hard Drives"
		end
	end
	
	desc "Load Graphics Cards"
	task :graphicscards => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Graphics_Card_list csv file
			File.open(RAILS_ROOT + '/doc/Graphics_Card_list.csv', 'r') do |file|
				while line = file.gets
					count = count + 1
					gcSpecs = line.split(',')
					gc = GraphicsCard.new
					gc.part_id = 1
					gc.parttype = gcSpecs[0]
					gc.manufacturer = gcSpecs[1]
					gc.chipmanufacturer = gcSpecs[2]
					gc.price = gcSpecs[3].to_i
					gc.model = gcSpecs[4]
					gc.series = gcSpecs[5]
					gc.coreclock = gcSpecs[6].to_i
					if gcSpecs[7] != "nil"
					    gc.shaderclock = gcSpecs[7].to_i
					end
					gc.memoryclock = gcSpecs[8].to_i
					gc.memorysize = gcSpecs[9].to_i
					gc.memorytype = gcSpecs[10]
					gc.directx = gcSpecs[11].to_i
					gc.width = gcSpecs[12]
					gc.length = gcSpecs[13].to_i
					gc.interface = gcSpecs[14]
					gc.gpu = gcSpecs[15]
					if gcSpecs[16] == "yes"
					    gc.multigpusupport = true
					else
					    gc.multigpusupport = false
					end
					gc.maxresolution = gcSpecs[17]
					gc.hdmi = gcSpecs[18].to_i
					gc.dvi = gcSpecs[19].to_i
					gc.displayport = gcSpecs[20].to_i
					gc.vga = gcSpecs[21].to_i
					gc.svideo = gcSpecs[22].to_i
					gc.minpower = gcSpecs[23].to_i
					gc.multigpupower = gcSpecs[24].to_i
					gc.power8pin = 0
					gc.power6pin = 0
					gcSpecs[25].split('+').each do |power|
					    if power.to_i == 6
					        gc.power6pin += 1
						elsif power.to_i == 8
					        gc.power8pin += 1
						else
						    gc.power8pin = 0
							gc.power6pin = 0
						end
					end
					gc.manufacturerwebsite = gcSpecs[26]
					gc.googleprice = gcSpecs[27]
					if gc.valid?
					    newPart = Part.new
						newPart.parttype = gcSpecs[0]
						newPart.save!
						gc.part_id = newPart.id
						gc.save!
					else
					    #If it is not valid print what line is not valid along with
						#detailed error messages
						puts "\nGraphics Card at line #{count} is not valid"
						puts gc.errors.full_messages
					end
				end
			end
			puts "All Graphics Cards loaded"
		#rescue Exception
		 #   puts "No csv file for Graphics Cards"
		end
	end
	
	desc "Load Memory"
	task :memory => :environment do
	    #Line count for error reporting
	    count = 0
		begin
			#Open Memory_list csv file
			File.open(RAILS_ROOT + '/doc/Memory_list.csv', 'r') do |file|
				while line = file.gets
					count = count + 1
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
					memory.volage = memorySpecs[15].to_f
					if memory.valid?
					    newPart = Part.new
						newPart.parttype = memorySpecs[0]
						newPart.save!
						memory.part_id = newPart.id
						memory.save
					else
					    #If it is not valid print what line is not valid along with
						#detailed error messages
						puts "\nMemory at line #{count} is not valid"
						puts memory.errors.full_messages
					end
				end
			end
			puts "All Memory loaded"
		rescue Exception
		    puts "No csv file for Memory"
		end
	end
	
	desc "Load All Parts"
	task :loadparts => [:environment, 'db:reset', :fake, :memory, :graphicscards, :harddrives,
	    :discdrives, :monitors, :cpus, :coolers, :cases, :powersupplies, :motherboards]
end