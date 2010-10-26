require 'test_helper'

class GraphicsCardTest < ActiveSupport::TestCase
  
    test "Accepts good Graphics Cards" do
	    assert graphics_cards(:GoodGraphicsCardOne).valid?
		assert graphics_cards(:GoodGraphicsCardTwo).valid?
	end
	
	test "Rejects null part_id" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.part_id = nil
		assert !gc.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !graphics_cards(:NegativePartIdGraphicsCard).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !graphics_cards(:ZeroPartIdGraphicsCard).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !graphics_cards(:NonExistantPartIdGraphicsCard).valid?
	end
	
	test "Rejects null parttype" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.parttype = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit parttype" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.parttype = 'x'*20
		assert !gc.valid?
	end
	
	test "Rejects non graphics card parttype" do
	    assert !graphics_cards(:NonGpuGraphicsCard).valid?
	end
	
	test "Rejects null manufacturer" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.manufacturer = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.manufacturer = 'x'*25
		assert !gc.valid?
	end
	
	test "Rejects null chipmanufacturer" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.chipmanufacturer = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit chipmanufacturer" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.chipmanufacturer = 'x'*15
		assert !gc.valid?
	end
	
	test "Rejects null price" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.price = nil
		assert !gc.valid?
	end
	
	test "Rejects negative price" do
	    assert !graphics_cards(:NegativePriceGraphicsCard).valid?
	end
	
	test "Rejects zero price" do
	    assert !graphics_cards(:ZeroPriceGraphicsCard).valid?
	end
	
	test "Rejects null model" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.model = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit model" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.model = 'x'*55
		assert !gc.valid?
	end
	
	test "Rejects over length limit series" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.series = 'x'*35
		assert !gc.valid?
	end
	
	test "Rejects null coreclock" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.coreclock = nil
		assert !gc.valid?
	end
	
	test "Rejects negative coreclock" do
	    assert !graphics_cards(:NegativeCoreClockGraphicsCard).valid?
	end
	
	test "Rejects zero coreclock" do
	    assert !graphics_cards(:ZeroCoreClockGraphicsCard).valid?
	end
	
	test "Rejects negative shaderclock" do
	    assert !graphics_cards(:NegativeShaderClockGraphicsCard).valid?
	end
	
	test "Rejects zero shaderclock" do
	    assert !graphics_cards(:ZeroShaderClockGraphicsCard).valid?
	end
	
	test "Rejects null memoryclock" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.memoryclock = nil
		assert !gc.valid?
	end
	
	test "Rejects negative memoryclock" do
	    assert !graphics_cards(:NegativeMemoryClockGraphicsCard).valid?
	end
	
	test "Rejects zero memoryclock" do
	    assert !graphics_cards(:ZeroMemoryClockGraphicsCard).valid?
	end
	
	test "Rejects null memorysize" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.memorysize = nil
		assert !gc.valid?
	end
	
	test "Rejects negative memorysize" do
	    assert !graphics_cards(:NegativeMemorySizeGraphicsCard).valid?
	end
	
	test "Rejects zero memorysize" do
	    assert !graphics_cards(:ZeroMemorySizeGraphicsCard).valid?
	end
	
	test "Rejects null memorytype" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.memorytype = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit memorytype" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.memorytype = 'x'*10
		assert !gc.valid?
	end
	
	test "Rejects null directx" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.directx = nil
		assert !gc.valid?
	end
	
	test "Rejects negative directx" do
	    assert !graphics_cards(:NegativeDirectXGraphicsCard).valid?
	end
	
	test "Rejects zero directx" do
	    assert !graphics_cards(:ZeroDirectXGraphicsCard).valid?
	end
	
	test "Rejects null width" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.width = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit width" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.width = 'x'*15
		assert !gc.valid?
	end
	
	test "Rejects null length" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.length = nil
		assert !gc.valid?
	end
	
	test "Rejects negative length" do
	    assert !graphics_cards(:NegativeLengthGraphicsCard).valid?
	end
	
	test "Rejects zero length" do
	    assert !graphics_cards(:ZeroLengthGraphicsCard).valid?
	end
	
	test "Rejects null interface" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.interface = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit interface" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.interface = 'x'*20
		assert !gc.valid?
	end
	
	test "Rejects null gpu" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.gpu = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit gpu" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.gpu = 'x'*15
		assert !gc.valid?
	end
	
	test "Rejects null multigpusupport" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.multigpusupport = nil
		assert !gc.valid?
	end
	
	test "Rejects null maxresolution" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.maxresolution = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit maxresolution" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.maxresolution = 'x'*15
		assert !gc.valid?
	end
	
	test "Rejects null hdmi" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.hdmi = nil
		assert !gc.valid?
	end
	
	test "Rejects negative hdmi" do
	    assert !graphics_cards(:NegativeHDMIGraphicsCard).valid?
	end
	
	test "Rejects null dvi" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.dvi = nil
		assert !gc.valid?
	end
	
	test "Rejects negative dvi" do
	    assert !graphics_cards(:NegativeDVIGraphicsCard).valid?
	end
	
	test "Rejects null displayport" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.dvi = nil
		assert !gc.valid?
	end
	
	test "Rejects negative displayport" do
	    assert !graphics_cards(:NegativeDisplayPortGraphicsCard).valid?
	end
	
	test "Rejects null vga" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.vga = nil
		assert !gc.valid?
	end
	
	test "Rejects negative vga" do
	    assert !graphics_cards(:NegativeVGAGraphicsCard).valid?
	end
	
	test "Rejects null svideo" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.svideo = nil
		assert !gc.valid?
	end
	
	test "Rejects negative svideo" do
	    assert !graphics_cards(:NegativeSVideoGraphicsCard).valid?
	end
	
	test "Rejects null minpower" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.minpower = nil
		assert !gc.valid?
	end
	
	test "Rejects negative minpower" do
	    assert !graphics_cards(:NegativeMinPowerGraphicsCard).valid?
	end
	
	test "Rejects zero minpower" do
	    assert !graphics_cards(:ZeroMinPowerGraphicsCard).valid?
	end
	
	test "Rejects negative multigpupower" do
	    assert !graphics_cards(:NegativeMultiGpuPowerGraphicsCard).valid?
	end
	
	test "Rejects zero multigpupower" do
	    assert !graphics_cards(:ZeroMultiGpuPowerGraphicsCard).valid?
	end
	
	test "Rejects null power6pin" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.power6pin = nil
		assert !gc.valid?
	end
	
	test "Rejects negative power6pin" do
	    assert !graphics_cards(:NegativePower6PinGraphicsCard).valid?
	end
	
	test "Rejects null power8pin" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.power8pin = nil
		assert !gc.valid?
	end
	
	test "Rejects negative power8pin" do
	    assert !graphics_cards(:NegativePower8PinGraphicsCard).valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.manufacturerwebsite = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.manufacturerwebsite = 'x'*260
		assert !gc.valid?
	end
	
	test "Rejects null googleprice" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.googleprice = nil
		assert !gc.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    gc = graphics_cards(:GoodGraphicsCardOne)
		gc.googleprice = 'x'*260
		assert !gc.valid?
	end
end