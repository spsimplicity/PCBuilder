#For my Desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load Case data from csv file into the database."
task :cases => :environment do
    #Line cound for error reporting
    count = 0
    begin
        #Open Case list csv file
	caseFile = File.open(Dir.pwd+'/doc/case_list - Copy.csv', 'r')
	while line = caseFile.gets
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
	    compCase.casetype = caseSpecs[13].to_i
	    compCase.length = caseSpecs[14].to_i
	    compCase.width = caseSpecs[15].to_i
	    compCase.height = caseSpecs[16].to_i
	    compCase.maxcoolerheight = caseSpecs[18].to_i
	    compCase.maxgpulength = caseSpecs[19].to_i
	    if compCase.valid?
	        newPart = Part.new
		newPart.parttype = caseSpecs[0]
		newPart.save!
		compCase.part_id = newPart.id
		compCase.save!
		#Make a new case_motherboard for each mobo size the case is
		#compatible with
		caseSpecs[17].split('/').each do |size|
                    caseMobo = CaseMotherboard.new
		    caseMobo.case_id = compCase.id
		    caseMobo.size = size
		    if caseMobo.valid?
                        caseMobo.save!
		    else
		        #If it is not valid print what line is not valid along
			#with detailed error messages
			puts "\nSizes at line #{count} are not valid"
			puts caseMobo.errors.full_messages
		    end
		end
	     else
                #If it is not valid print what line is not valid along with
		#detailed error messages
		puts "\nCase at line #{count} are not valid"
		puts compCase.errors.full_messages
	     end
	end
	puts "All Cases loaded"
    rescue
        puts "No csv file for Cases"
    end
end
