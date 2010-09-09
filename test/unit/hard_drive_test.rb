require 'test_helper'

class HardDriveTest < ActiveSupport::TestCase

  test "Accepts good hard drives" do
	    assert hard_drives(:GoodHardDriveOne).valid?
		assert hard_drive(:GoodHardDriveTwo).valid?
	end
	
	test "Rejects null part_id" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.part_id = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !hard_drive(:NegativePartIdHardDrive).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !hard_drive(:ZeroPartIdHardDrive).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !hard_drive(:NonExistantPartIdHardDrive).valid?
	end
	
	test "Rejects null parttype" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.parttype = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit parttype" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.parttype = 'x'*20
		assert !hdd.valid?
	end
	
	test "Rejects not hard drive patytype" do
	    assert !hard_drive(:NonHDDPartTypeHardDrive).valid?
	end
	
	test "Rejects null manufacturer" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.manufacturer = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.manufacturer = 'x'*35
		assert !hdd.valid?
	end
	
	test "Rejects null model" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.model = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit model" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.model = 'x'*45
		assert !hdd.valid?
	end
	
	test "Rejects over length limit series" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.series = 'x'*30
		assert !hdd.valid?
	end
	
	test "Rejects null price" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.price = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative price" do
	    assert !hard_drive(:NegativePriceHardDrive).valid?
	end
	
	test "Rejects zero price" do
	    assert !hard_drive(:ZeroPriceHardDrive).valid?
	end
	
	test "Rejects null interface" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.interface = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit interface" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.interface = 'x'*25
		assert !hdd.valid?
	end
	
	test "Rejects not accepted interface type" do
	    assert !hard_drive(:NotSupportedInterfaceHardDrive).valid?
	end
	
	test "Rejects null capacity" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.capacity = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative capacity" do
	    assert !hard_drive(:NegativeCapacityHardDrive).valid?
	end
	
	test "Rejects zero capacity" do
	    assert !hard_drive(:ZeroCapacityHardDrive).valid?
	end
	
	test "Rejects null rpm" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.rpm = nil
		assert !hdd.valid?
	end
	
	test "Rejects negative rpm" do
	    assert !hard_drive(:NegativeRPMHardDrive).valid?
	end
	
	test "Rejects zero rpm" do
	    assert !hard_drive(:ZeroRPMHardDrive).valid?
	end
	
	test "Rejects negative cache" do
	    assert !hard_drive(:NegativeCacheHardDrive).valid?
	end
	
	test "Rejects zero cache" do
	    assert !hard_drive(:ZeroCacheHardDrive).valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.manufacturerwebsite = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.manufacturerwebsite = 'x'*300
		assert !hdd.valid?
	end
	
	test "Rejects null googleprice" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.googleprice = nil
		assert !hdd.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    hdd = hard_drive(:GoodHardDriveOne)
		hdd.googleprice = 'x'*300
		assert !hdd.valid?
	end
end
