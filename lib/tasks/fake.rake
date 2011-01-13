desc "Create a fake part for initial creation of parts, and loading them into
the database"
task :fake => :environment do
	#Fake first part to allow validation
	begin
		#Tries to find the first part
		Part.find(1).parttype
		puts "fake already exists"
	#If there is no first part then it jumps down to the
	#exeption handler
	rescue
		partFake = Part.new
		partFake.parttype = "FAKE"
		partFake.save!
	end
end