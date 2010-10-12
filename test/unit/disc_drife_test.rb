require 'test_helper'

class DiscDrifeTest < ActiveSupport::TestCase
  
    test "Accepts good disc drives" do
	    assert disc_drives(:GoodDiscDriveOne).valid?
	    assert disc_drives(:GoodDiscDriveTwo).valid?
	end
	
	test "Rejects null part_id" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.part_id = nil
		assert !dd.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !disc_drives(:NegativePartIdDiscDrive).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !disc_drives(:ZeroPartIdDiscDrive).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !disc_drives(:NonExistantPartIdDiscDrive).valid?
	end
	
	test "Rejects null parttype" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.parttype = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit parttype" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.parttype = 'x'*15
		assert !dd.valid?
	end
	
	test "Rejects non disc drive parttype" do
	    assert !disc_drives(:NonDrivePartTypeDiscDrive).valid?
	end
	
	test "Rejects null manufacturer" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.manufacturer = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.manufacturer = 'x'*35
		assert !dd.valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.manufacturerwebsite = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.manufacturerwebsite = 'x'*260
		assert !dd.valid?
	end
	
	test "Rejects null price" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.price = nil
		assert !dd.valid?
	end
	
	test "Rejects negative price" do
	    assert !disc_drives(:NegativePriceDiscDrive).valid?
	end
	
	test "Rejects zero price" do
	    assert !disc_drives(:ZeroPriceDiscDrive).valid?
	end
	
	test "Rejects null googleprice" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.googleprice = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.googleprice = 'x'*260
		assert !dd.valid?
	end
	
	test "Rejects null model" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.model = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit model" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.model = 'x'*25
		assert !dd.valid?
	end
	
	test "Rejects null interface" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.interface = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit interface" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.interface = 'x'*15
		assert !dd.valid?
	end
	
	test "Rejects non supported interface" do
	    assert !disc_drives(:NonSupportedInterfaceDiscDrive).valid?
	end
	
	test "Rejects negative cache" do
	    assert !disc_drives(:NegativeCacheDiscDrive).valid?
	end
	
	test "Rejects zero cache" do
	    assert !disc_drives(:ZeroCacheDiscDrive).valid?
	end
	
	test "Rejects null drivetype" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.drivetype = nil
		assert !dd.valid?
	end
	
	test "Rejects over length limit drivetype" do
	    dd = disc_drives(:GoodDiscDriveOne)
		dd.drivetype = 'x'*20
		assert !dd.valid?
	end
end
