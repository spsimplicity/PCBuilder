require 'test_helper'

class WriteSpeedTest < ActiveSupport::TestCase
  
    test "Accepts good write speeds" do
	    assert write_speeds(:GoodWriteSpeedOne).valid?
		assert write_speeds(:GoodWriteSpeedOne).valid?
	end
	
	test "Rejects null disc_drive_id" do
	    rs = write_speeds(:GoodWriteSpeedOne)
		rs.disc_drife_id = nil
		assert !rs.valid?
	end
	
	test "Rejects negative disc_drive_id" do
	    assert !write_speeds(:NegativeDriveIdWriteSpeed).valid?
	end
	
	test "Rejects zero disc_drive_id" do
	    assert !write_speeds(:ZeroDriveIdWriteSpeed).valid?
	end
	
	test "Rejects non existant disc_drive_id" do
	    assert !write_speeds(:NonExistantDriveIdWriteSpeed).valid?
	end
	
	test "Rejects null writetype" do
	    rs = write_speeds(:GoodWriteSpeedOne)
		rs.writetype = nil
		assert !rs.valid?
	end
	
	test "Rejects over length limit writetype" do
	    rs = write_speeds(:GoodWriteSpeedOne)
		rs.writetype = 'x'*20
		assert !rs.valid?
	end
	
	test "Rejects null speed" do
	    rs = write_speeds(:GoodWriteSpeedOne)
		rs.speed = nil
		assert !rs.valid?
	end
	
	test "Rejects negative speed" do
	    assert !write_speeds(:NegativeSpeedWriteSpeed).valid?
	end
	
	test "Rejects zero speed" do
	    assert !write_speeds(:ZeroSpeedWriteSpeed).valid?
	end
end
