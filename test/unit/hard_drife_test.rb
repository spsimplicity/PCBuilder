require 'test_helper'

class HardDrifeTest < ActiveSupport::TestCase

    test "Accepts good hard drives" do
	    assert hard_drives(:GoodHardDriveOne).valid?
		assert hard_drives(:GoodHardDriveTwo).valid?
	end
	
	test "Rejects null part_id" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.part_id = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !hard_drives(:NegativePartIdHardDrive).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !hard_drives(:ZeroPartIdHardDrive).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !hard_drives(:NonExistantPartIdHardDrive).valid?
	end
	
	test "Rejects null parttype" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.parttype = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit parttype" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.parttype = 'x'*20
		assert !hdd.valid?
	end
	
	test "Rejects non hdd parttype" do
	    assert !hard_drives(:NonHDDPartTypeHardDrive).valid?
	end
	
	test "Rejects null manufacturer" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.manufacturer = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.manufacturer = 'x'*25
		assert !hdd.valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.manufacturerwebsite = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.manufacturerwebsite = 'x'*260
		assert !hdd.valid?
	end
	
	test "Rejects null googleprice" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.googleprice = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.googleprice = 'x'*260
		assert !hdd.valid?
	end
	
	test "Rejects null model" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.model = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit model" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.model = 'x'*35
		assert !hdd.valid?
	end
	
	test "Rejects over length limit series" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.series = 'x'*25
		assert !hdd.valid?
	end
	
	test "Rejects null price" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.price = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative price" do
	    assert !hard_drives(:NegativePriceHardDrive).valid?
	end
	
	test "Rejects zero price" do
	    assert !hard_drives(:ZeroPriceHardDrive).valid?
	end
	
	test "Rejects null interface" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.interface = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit interface" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.interface = 'x'*15
		assert !hdd.valid?
	end
	
	test "Rejects non supported inteface" do
	    assert !hard_drives(:NonSupportedInterfaceHardDrive).valid?
	end
	
	test "Rejects null capacity" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.capacity = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative capacity" do
	    assert !hard_drives(:NegativeCapacityHardDrive).valid?
	end
	
	test "Rejects zero capacity" do
	    assert !hard_drives(:ZeroCapacityHardDrive).valid?
	end
	
	test "Rejects null rpm" do
	    hdd = hard_drives(:GoodHardDriveOne)
		hdd.rpm = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative rpm" do
	    assert !hard_drives(:NegativeRPMHardDrive).valid?
	end
	
	test "Rejects zero rpm" do
	    assert !hard_drives(:ZeroRPMHardDrive).valid?
	end
	
	test "Rejects negative cache" do
	    assert !hard_drives(:NegativeCacheHardDrive).valid?
	end
	
	test "Rejects zero cache" do
	    assert !hard_drives(:ZeroCacheHardDrive).valid?
	end
end
