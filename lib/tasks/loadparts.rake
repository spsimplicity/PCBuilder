#For my desktop
#RAILS_ROOT = 'C:/Users/simplicity/rails_projects/PCBuilder'
#For my laptop
#RAILS_ROOT = 'C:/Documents and Settings/Owner/My Documents/Rails Projects/PCBuilder'

desc "Load All Parts"
task :loadparts => [:environment, 'db:reset', :fake, :memory, :graphicscards, :harddrives,
	:discdrives, :monitors, :cpus, :coolers, :cases, :powersupplies, :motherboards]

desc "Insert into incompatibles"
task :compatible => :environment do
	cpus = Cpu.find(:all)
	cpus.each do |cpu|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{cpu.part_id}, 'CPU')")
		ActiveRecord::Base.connection.reconnect!
	end
	coolers = CpuCooler.find(:all)
	coolers.each do |cooler|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{cooler.part_id}, 'CPU Cooler')")
		ActiveRecord::Base.connection.reconnect!
	end
	graphics = GraphicsCard.find(:all)
	graphics.each do |card|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{card.part_id}, 'Graphics Card')")
		ActiveRecord::Base.connection.reconnect!
	end
	hdds = HardDrife.find(:all)
	hdds.each do |hdd|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{hdd.part_id}, 'Hard Drive')")
		ActiveRecord::Base.connection.reconnect!
	end
	dds = DiscDrife.find(:all)
	dds.each do |dd|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{dd.part_id}, 'Disc Drive')")
		ActiveRecord::Base.connection.reconnect!
	end
	psus = PowerSupply.find(:all)
	psus.each do |psu|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{psu.part_id}, 'Power Supply')")
		ActiveRecord::Base.connection.reconnect!
	end
	mobos = Motherboard.find(:all)
	mobos.each do |mobo|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{mobo.part_id}, 'Motherboard')")
		ActiveRecord::Base.connection.reconnect!
	end
	mons = Display.find(:all)
	mons.each do |mon|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{mon.part_id}, 'Monitor')")
		ActiveRecord::Base.connection.reconnect!
	end
	mems = Memory.find(:all)
	mems.each do |mem|
	    ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{mem.part_id}, 'Memory')")
		ActiveRecord::Base.connection.reconnect!
	end
	cases = Case.find(:all)
	cases.each do |cas|
		ActiveRecord::Base.connection.execute("call compatibilityAlgorithmTest(#{cas.part_id}, 'Case')")
		ActiveRecord::Base.connection.reconnect!
	end
end

desc "Loads all parts and calls incompatibility algorithm"
task :determineCompatibility => [:environment, 'db:reset', :fake, :motherboards, :harddrives,
	:cpus, :coolers, :powersupplies, :graphicscards, :cases, :memory, :monitors, :compatible]