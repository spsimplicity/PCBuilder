require 'test_helper'

class MemoryTest < ActiveSupport::TestCase
  
    test "Accepts good Memory" do
	    assert memories(:GoodMemoryOne).valid?
	    assert memories(:GoodMemoryTwo).valid?
	end
	
	test "Rejects null part_id" do
	    mem = memories(:GoodMemoryOne)
		mem.part_id = nil
		assert !mem.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !memories(:NegativePartIdMemory).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !memories(:ZeroPartIdMemory).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !memories(:NonExistantPartIdMemory).valid?
	end
	
	test "Rejects null parttype" do
	    mem = memories(:GoodMemoryOne)
		mem.parttype = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit parttype" do
	    mem = memories(:GoodMemoryOne)
		mem.parttype = 'x'*15
		assert !mem.valid?
	end
	
	test "Rejects non memory parttype" do
	    assert !memories(:NonMemoryPartTypeMemory).valid?
	end
	
	test "Rejects null manufacturer" do
	    mem = memories(:GoodMemoryOne)
		mem.manufacturer = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    mem = memories(:GoodMemoryOne)
		mem.manufacturer = 'x'*25
		assert !mem.valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    mem = memories(:GoodMemoryOne)
		mem.manufacturerwebsite = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    mem = memories(:GoodMemoryOne)
		mem.manufacturerwebsite = 'x'*260
		assert !mem.valid?
	end
	
	test "Rejects null price" do
	    mem = memories(:GoodMemoryOne)
		mem.price = nil
		assert !mem.valid?
	end
	
	test "Rejects negative price" do
	    assert !memories(:NegativePriceMemory).valid?
	end
	
	test "Rejects zero price" do
	    assert !memories(:ZeroPriceMemory).valid?
	end
	
	test "Rejects null googleprice" do
	    mem = memories(:GoodMemoryOne)
		mem.googleprice = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    mem = memories(:GoodMemoryOne)
		mem.googleprice = 'x'*260
		assert !mem.valid?
	end
	
	test "Rejects null model" do
	    mem = memories(:GoodMemoryOne)
		mem.model = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit model" do
	    mem = memories(:GoodMemoryOne)
		mem.model ='x'*35
		assert !mem.valid?
	end
	
	test "Rejects over length limit series" do
	    mem = memories(:GoodMemoryOne)
		mem.series ='x'*35
		assert !mem.valid?
	end
	
	test "Rejects null speed" do
	    mem = memories(:GoodMemoryOne)
		mem.speed = nil
		assert !mem.valid?
	end
	
	test "Rejects negative speed" do
	    assert !memories(:NegativeSpeedMemory).valid?
	end
	
	test "Rejects zero speed" do
	    assert !memories(:ZeroSpeedMemory).valid?
	end
	
	test "Rejects null timings" do
	    mem = memories(:GoodMemoryOne)
		mem.timings = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit timings" do
	    mem = memories(:GoodMemoryOne)
		mem.timings = 'x'*15
		assert !mem.valid?
	end
	
	test "Rejects null capacity" do
	    mem = memories(:GoodMemoryOne)
		mem.capacity = nil
		assert !mem.valid?
	end
	
	test "Rejects negative capacity" do
	    assert !memories(:NegativeCapacityMemory).valid?
	end
	
	test "Rejects zero capacity" do
	    assert !memories(:ZeroCapacityMemory).valid?
	end
	
	test "Rejects null multichanneltype" do
	    mem = memories(:GoodMemoryOne)
		mem.multichanneltype = nil
		assert !mem.valid?
	end
	
	test "Rejects negative multichanneltype" do
	    assert !memories(:NegativeMultiChannelMemory).valid?
	end
	
	test "Rejects zero multichanneltype" do
	    assert !memories(:ZeroMultiChannelMemory).valid?
	end
	
	test "Rejects null memorytype" do
	    mem = memories(:GoodMemoryOne)
		mem.memorytype = nil
		assert !mem.valid?
	end
	
	test "Rejects over length limit memorytype" do
	    mem = memories(:GoodMemoryOne)
		mem.memorytype = 'x'*10
		assert !mem.valid?
	end
	
	test "Rejects non ddr memorytype" do
	    assert !memories(:NonDDRMemory).valid?
	end
	
	test "Rejects null pinnumber" do
	    mem = memories(:GoodMemoryOne)
		mem.pinnumber = nil
		assert !mem.valid?
	end
	
	test "Rejects negative pinnumber" do
	    assert !memories(:NegativePinMemory).valid?
	end
	
	test "Rejects zero pinnumber" do
	    assert !memories(:ZeroPinMemory).valid?
	end
	
	test "Rejects null dimms" do
	    mem = memories(:GoodMemoryOne)
		mem.dimms = nil
		assert !mem.valid?
	end
	
	test "Rejects negative dimms" do
	    assert !memories(:NegativeDimmMemory).valid?
	end
	
	test "Rejects zero dimms" do
	    assert !memories(:ZeroDimmMemory).valid?
	end
	
	test "Rejects null totalcapacity" do
	    mem = memories(:GoodMemoryOne)
		mem.totalcapacity = nil
		assert !mem.valid?
	end
	
	test "Rejects negative totalcapacity" do
	    assert !memories(:NegativeTotalCapacityMemory).valid?
	end
	
	test "Rejects zero totalcapacity" do
	    assert !memories(:ZeroTotalCapacityMemory).valid?
	end
	
	test "Rejects null voltage" do
	    mem = memories(:GoodMemoryOne)
		mem.voltage = nil
		assert !mem.valid?
	end
	
	test "Rejects negative voltage" do
	    assert !memories(:NegativeVoltageMemory).valid?
	end
	
	test "Rejects zero voltage" do
	    assert !memories(:ZeroVoltageMemory).valid?
	end
end
