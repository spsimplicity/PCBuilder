require 'test_helper'

class ReadSpeedTest < ActiveSupport::TestCase
  
    test "Accepts good read speeds" do
	    assert read_speeds(:GoodReadSpeedOne).valid?
		assert read_speeds(:GoodReadSpeedTwo).valid?
	end
	
	test "Rejects null disc_drive_id" do
	    rs = read_speeds(:GoodReadSpeedOne)
		rs.disc_drife_id = nil
		assert !rs.valid?
	end
	
	test "Rejects negative disc_drive_id" do
	    assert !read_speeds(:NegativeDriveIdReadSpeed).valid?
	end
	
	test "Rejects zero disc_drive_id" do
	    assert !read_speeds(:ZeroDriveIdReadSpeed).valid?
	end
	
	test "Rejects non existant disc_drive_id" do
	    assert !read_speeds(:NonExistantDriveIdReadSpeed).valid?
	end
	
	test "Rejects null readtype" do
	    rs = read_speeds(:GoodReadSpeedOne)
		rs.readtype = nil
		assert !rs.valid?
	end
	
	test "Rejects over length limit readtype" do
	    rs = read_speeds(:GoodReadSpeedOne)
		rs.readtype = 'x'*20
		assert !rs.valid?
	end
	
	test "Rejects null speed" do
	    rs = read_speeds(:GoodReadSpeedOne)
		rs.speed = nil
		assert !rs.valid?
	end
	
	test "Rejects negative speed" do
	    assert !read_speeds(:NegativeSpeedReadSpeed).valid?
	end
	
	test "Rejects zero speed" do
	    assert !read_speeds(:ZeroSpeedReadSpeed).valid?
	end
end
