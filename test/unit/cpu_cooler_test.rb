require 'test_helper'

class CpuCoolerTest < ActiveSupport::TestCase
    
	test "Accepts good cpu_coolers" do
	    assert cpu_coolers(:GoodCpuCoolerOne).valid?
		assert cpu_coolers(:GoodCpuCoolerTwo).valid?
	end
	
	test "Rejects null parttype value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.parttype = nil
		assert !cooler.valid?
    end
	
	test "Rejects over length limit parttype value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.parttype = 'x'*20
		assert !cooler.valid?
	end
	
	test "Rejects non cpu cooler parttype" do
	    assert !cpu_coolers(:PartTypeWrongValue).valid?
	end
	
	test "Rejects null model value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.model = nil
		assert !cooler.valid?
	end
	
	test "Rejects over length limit model value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.model = 'x'*35
		assert !cooler.valid?
	end
	
	test "Rejects null manufacturer value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.manufacturer = nil
		assert !cooler.valid?
	end
	
	test "Rejects over length limit manufacturer value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.manufacturer = 'x'*25
		assert !cooler.valid?
	end
	
	test "Rejects null manufacturerwebsite value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.manufacturerwebsite = nil
		assert !cooler.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.manufacturerwebsite = 'x'*260
		assert !cooler.valid?
	end
	
	test "Rejects null price value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.price = nil
		assert !cooler.valid?
	end
	
	test "Rejects zero price value" do
	    assert !cpu_coolers(:ZeroPriceCpuCooler).valid?
	end
	
	test "Rejects Negative price value" do
	    assert !cpu_coolers(:NegativePriceCpuCooler).valid?
	end
	
	test "Rejects null googleprice value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.googleprice = nil
		assert !cooler.valid?
	end
	
	test "Rejects over length limit googleprice value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.googleprice = 'x'*260
		assert !cooler.valid?
	end
	
	test "Rejects zero maxmemheight value" do
	    assert !cpu_coolers(:ZeroMaxMemHeightCpuCooler).valid?
	end
	
	test "Rejects Negative maxmemheight value" do
	    assert !cpu_coolers(:NegativeMaxMemHeightCpuCooler).valid?
	end
	
	test "Rejects null height value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.height = nil
		assert !cooler.valid?
	end
	
	test "Rejects zero height value" do
	    assert !cpu_coolers(:ZeroHeightCpuCooler).valid?
	end
	
	test "Rejects Negative height value" do
	    assert !cpu_coolers(:NegativeHeightCpuCooler).valid?
	end
	
	test "Rejects null width value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.width = nil
		assert !cooler.valid?
	end
	
	test "Rejects zero width value" do
	    assert !cpu_coolers(:ZeroWidthCpuCooler).valid?
	end
	
	test "Rejects Negative width value" do
	    assert !cpu_coolers(:NegativeWidthCpuCooler).valid?
	end
	
	test "Rejects null length value" do
	    cooler = cpu_coolers(:GoodCpuCoolerOne)
		cooler.length = nil
		assert !cooler.valid?
	end
	
	test "Rejects zero length value" do
	    assert !cpu_coolers(:ZeroLengthCpuCooler).valid?
	end
	
	test "Rejects Negative length value" do
	    assert !cpu_coolers(:NegativeLengthCpuCooler).valid?
	end
end
