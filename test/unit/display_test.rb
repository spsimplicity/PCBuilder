require 'test_helper'

class DisplayTest < ActiveSupport::TestCase
  
    test "Accepts good monitors" do
	    assert displays(:GoodMonitorOne).valid?
	    assert displays(:GoodMonitorTwo).valid?
	end
	
	test "Rejects null part_id" do
	    disp = displays(:GoodMonitorOne)
		disp.part_id = nil
		assert !disp.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !displays(:NegativePartIdMonitor).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !displays(:ZeroPartIdMonitor).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !displays(:NonExistantPartIdMonitor).valid?
	end
	
	test "Rejects null parttype" do
	    disp = displays(:GoodMonitorOne)
		disp.parttype = nil
		assert !disp.valid?
	end
	
	test "Rejects non monitor parttype" do
	    assert !displays(:NonMonitorPartTypeMonitor).valid?
	end
	
	test "Rejects over length limit parttype" do
	    disp = displays(:GoodMonitorOne)
		disp.parttype = 'x'*15
		assert !disp.valid?
	end
	
	test "Rejects null manufacturer" do
	    disp = displays(:GoodMonitorOne)
		disp.manufacturer = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    disp = displays(:GoodMonitorOne)
		disp.manufacturer = 'x'*25
		assert !disp.valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    disp = displays(:GoodMonitorOne)
		disp.manufacturerwebsite = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    disp = displays(:GoodMonitorOne)
		disp.manufacturerwebsite = 'x'*260
		assert !disp.valid?
	end
	
	test "Rejects null price" do
	    disp = displays(:GoodMonitorOne)
		disp.price = nil
		assert !disp.valid?
	end
	
	test "Rejects negative price" do
	    assert !displays(:NegativePriceMonitor).valid?
	end
	
	test "Rejects zero price" do
	    assert !displays(:ZeroPriceMonitor).valid?
	end
	
	test "Rejects null googleprice" do
	    disp = displays(:GoodMonitorOne)
		disp.googleprice = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    disp = displays(:GoodMonitorOne)
		disp.googleprice = 'x'*260
		assert !disp.valid?
	end
	
	test "Rejects null model" do
	    disp = displays(:GoodMonitorOne)
		disp.model = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit model" do
	    disp = displays(:GoodMonitorOne)
		disp.model = 'x'*35
		assert !disp.valid?
	end
	
	test "Rejects null contrastratio" do
	    disp = displays(:GoodMonitorOne)
		disp.contrastratio = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit contrastratio" do
	    disp = displays(:GoodMonitorOne)
		disp.contrastratio = 'x'*20
		assert !disp.valid?
	end
	
	test "Rejects negative length" do
	    assert !displays(:NegativeLengthMonitor).valid?
	end
	
	test "Rejects zero length" do
	    assert !displays(:ZeroLengthMonitor).valid?
	end
	
	test "Rejects negative width" do
	    assert !displays(:NegativeWidthMonitor).valid?
	end
	
	test "Rejects zero width" do
	    assert !displays(:ZeroWidthMonitor).valid?
	end
	
	test "Rejects negative height" do
	    assert !displays(:NegativeHeightMonitor).valid?
	end
	
	test "Rejects zero height" do
	    assert !displays(:ZeroHeightMonitor).valid?
	end
	
	test "Rejects null resolution" do
	    disp = displays(:GoodMonitorOne)
		disp.resolution = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit resolution" do
	    disp = displays(:GoodMonitorOne)
		disp.resolution = 'x'*20
		assert !disp.valid?
	end
	
	test "Rejects null monitortype" do
	    disp = displays(:GoodMonitorOne)
		disp.monitortype = nil
		assert !disp.valid?
	end
	
	test "Rejects over length limit monitortype" do
	    disp = displays(:GoodMonitorOne)
		disp.monitortype = 'x'*10
		assert !disp.valid?
	end
	
	test "Rejects non supported monitortype" do
	    assert !displays(:NonSupportedMonitorTypeMonitor).valid?
	end
	
	test "Rejects null screensize" do
	    disp = displays(:GoodMonitorOne)
		disp.screensize = nil
		assert !disp.valid?
	end
	
	test "Rejects negative screensize" do
	    assert !displays(:NegativeScreenSizeMonitor).valid?
	end
	
	test "Rejects zero screensize" do
	    assert !displays(:ZeroScreenSizeMonitor).valid?
	end
	
	test "Rejects null widescreen" do
	    disp = displays(:GoodMonitorOne)
		disp.widescreen = nil
		assert !disp.valid?
	end
	
	test "Rejects negative displaycolors" do
	    assert !displays(:NegativeDisplayColorsMonitor).valid?
	end
	
	test "Rejects null vga" do
	    disp = displays(:GoodMonitorOne)
		disp.vga = nil
		assert !disp.valid?
	end
	
	test "Rejects negative vga" do
	    assert !displays(:NegativeVGAMonitor).valid?
	end
	
	test "Rejects null hdmi" do
	    disp = displays(:GoodMonitorOne)
		disp.hdmi = nil
		assert !disp.valid?
	end
	
	test "Rejects negative hdmi" do
	    assert !displays(:NegativeHDMIMonitor).valid?
	end
	
	test "Rejects null svideo" do
	    disp = displays(:GoodMonitorOne)
		disp.svideo = nil
		assert !disp.valid?
	end
	
	test "Rejects negative svideo" do
	    assert !displays(:NegativeSVideoMonitor).valid?
	end
	
	test "Rejects null dvi" do
	    disp = displays(:GoodMonitorOne)
		disp.dvi = nil
		assert !disp.valid?
	end
	
	test "Rejects negative dvi" do
	    assert !displays(:NegativeDVIMonitor).valid?
	end
	
	test "Rejects null displayport" do
	    disp = displays(:GoodMonitorOne)
		disp.displayport = nil
		assert !disp.valid?
	end
	
	test "Rejects negative displayport" do
	    assert !displays(:NegativeDisplayPortMonitor).valid?
	end
end
