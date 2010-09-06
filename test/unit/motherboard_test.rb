require 'test_helper'

class MotherboardTest < ActiveSupport::TestCase
  
    test "Accepts good Motherboards" do
	    assert motherboards(:GoodMotherboardOne).valid?
		assert motherboards(:GoodMotherboardTwo).valid?
	end
	
	test "Rejects null parttype" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.parttype = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit parttype" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.parttype = 'x'*20
		assert !mobo.valid?
	end
	
	test "Rejects non 'motherboard' parttype" do
	    assert !motherboards(:NonMotherboardParttype).valid?
	end
	
	test "Rejects null manufacturer" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.manufacturer = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.manufacturer = 'x'*20
		assert !mobo.valid?
	end
	
	test "Rejects null model" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.model = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit model" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.model = 'x'*45
		assert !mobo.valid?
    end
	
	test "Rejects null price" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.price = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative price" do
	    assert !motherboards(:NegativeMotherboardPrice).valid?
	end
	
	test "Rejects zero price" do
	    assert !motherboards(:ZeroMotherboardPrice).valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.manufacturerwebsite = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.manufacturerwebsite = 'x'*260
		assert !mobo.valid?
	end
	
	test "Rejects null googleprice" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.googleprice = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.googleprice = 'x'*260
		assert !mobo.valid?
	end
	
	test "Rejects null maxmemory" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.maxmemory = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative maxmemory" do
	    assert !motherboards(:NegativeMotherboardMaxMemory).valid?
	end
	
	test "Rejects zero maxmemory" do
	    assert !motherboards(:ZeroMotherboardMaxMemory).valid?
	end
	
	test "Rejects null memorytype" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.memorytype = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit memorytype" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.memorytype = 'x'*6
		assert !mobo.valid?
	end
	
	test "Rejects non ddr type" do
	    assert !motherboards(:NonDDRMotherboardMemoryType).valid?
	end
	
	test "Rejects null pci_ex16" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.pci_ex16 = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative pci_ex16" do
	    assert !motherboards(:NegativeMotherboardPCI_EX16).valid?
	end
	
	test "Rejects null pci_e2" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.pci_e2 = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative pci_e2" do
	    assert !motherboards(:NegativeMotherboardPCI_E2).valid?
	end
	
	test "Rejects null memoryslots" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.memoryslots = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative memoryslots" do
	    assert !motherboards(:NegativeMotherboardMemorySlots).valid?
	end
	
	test "Rejects zero memoryslots" do
	    assert !motherboards(:ZeroMotherboardMemorySlots).valid?
	end 
	
	test "Rejects null size" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.size = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit size" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.size = 'x'*20
		assert !mobo.valid?
	end
	
	test "Rejects non standard size" do
	    assert !motherboards(:NonStandardMotherboardSize).valid?
	end
	
	test "Rejects null cpupowerpin" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.cpupowerpin = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative cpupowerpin" do
	    assert !motherboards(:NegativeMotherboardCpuPowerPin).valid?
	end
	
	test "Rejects zero cpupowerpin" do
	    assert !motherboards(:ZeroMotherboardCpuPowerPin).valid?
	end
	
	test "Rejects null fsb" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.fsb = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative fsb" do
	    assert !motherboards(:NegativeMotherboardFSB).valid?
	end
	
	test "Rejects zero fsb" do
	    assert !motherboards(:ZeroMotherboardFSB).valid?
	end
	
	test "Rejects null northbridge" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.northbridge = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit northbridge" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.northbridge = 'x'*30
		assert !mobo.valid?
	end
	
	test "Rejects over length limit southbridge" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.southbridge = 'x'*30
		assert !mobo.valid?
	end
	
	test "Rejects null mainpower" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.mainpower = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative mainpower" do
	    assert !motherboards(:NegativeMotherboardMainPower).valid?
	end
	
	test "Rejects zero mainpower" do
	    assert !motherboards(:ZeroMotherboardMainPower).valid?
	end
	
	test "Rejects null pci_e" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.pci_e = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative pci_e" do
	    assert !motherboards(:NegativeMotherboardPCI_E).valid?
	end
	
	test "Rejects null pci" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.pci = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative pci" do
	    assert !motherboards(:NegativeMotherboardPCI).valid?
	end
	
	test "Rejects null sli_crossfire" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.sli_crossfire = nil
		assert !mobo.valid?
	end
	
	test "Rejects null sockettype" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.sockettype = nil
		assert !mobo.valid?
	end
	
	test "Rejects over length limit sockettype" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.sockettype = 'x'*15
		assert !mobo.valid?
	end
	
	test "Rejects null sata3" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.sata3 = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative sata3" do
	    assert !motherboards(:NegativeMotherboardSata3).valid?
	end
	
	test "Rejects null sata6" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.sata6 = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative sata6" do
	    assert !motherboards(:NegativeMotherboardSata6).valid?
	end
	
	test "Rejects null ide" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.ide = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative ide" do
	    assert !motherboards(:NegativeMotherboardIDE).valid?
	end
	
	test "Rejects null part_id" do
	    mobo = motherboards(:GoodMotherboardOne)
		mobo.part_id = nil
		assert !mobo.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !motherboards(:NegativeMotherboardPartId).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !motherboards(:ZeroMotherboardPartId).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !motherboards(:NonExistantMotherboardPartId).valid?
	end
end
