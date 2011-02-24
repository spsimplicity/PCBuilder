#For my desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PBuilder'

desc "Loads Graphics Card data from csv file into database."
task :graphicscards => :environment do
    #Line count for error reporting
    count = 0
    begin
        gcFile = File.open(Dir.pwd+'/doc/Graphics_Card_List - Copy.csv', 'r')
	while line = gcFile.gets
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
	    gc.multigpusupport = gcSpecs[16].to_i
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
	puts "All Graphics Cards loaded"
    rescue
        puts "No csv file for Graphics Cards"
    end
end
