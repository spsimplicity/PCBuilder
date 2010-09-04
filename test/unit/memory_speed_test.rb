require 'test_helper'

class MemorySpeedTest < ActiveSupport::TestCase
  
     test "Accepts good memory speeds" do
         assert memory_speeds(:GoodMemorySpeedOne).valid?
		 assert memory_speeds(:GoodMemorySpeedTwo).valid?
	 end
	 
	 test "Rejects null motherboard_id" do
	     memspeed = memory_speeds(:GoodMemorySpeedOne)
		 memspeed.motherboard_id = nil
		 assert !memspeed.valid?
	 end
	 
	 test "Rejects negative motherboard_id" do
	     assert !memory_speeds(:NegativeMotherboardIdMemorySpeed).valid?
	 end
	 
	 test "Rejects zero motherboard_id" do
	     assert !memory_speeds(:ZeroMotherboardIdMemorySpeed).valid?
	 end
	 
	 test "Rejects non existant motherboard_id" do
	     assert !memory_speeds(:NonExistantMotherboardIdMemorySpeed).valid?
	 end
	 
	 test "Rejects null speed" do
	     memspeed = memory_speeds(:GoodMemorySpeedOne)
		 memspeed.speed = nil
		 assert !memspeed.valid?
	 end
	 
	 test "Rejects zerp speed" do
	     assert !memory_speeds(:NegativeSpeedMemorySpeed).valid?
	 end
	 
	 test "Rejects negative speed" do
	     assert !memory_speeds(:ZeroSpeedMemorySpeed).valid?
	 end
end
