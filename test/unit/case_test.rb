require 'test_helper'

class CaseTest < ActiveSupport::TestCase
  
    test "Accepts good cases" do
	    assert cases(:GoodCaseOne).valid?
		assert cases(:GoodCaseTwo).valid?
	end
	
	test "Rejects null parttype" do
	    compcase = cases(:GoodCaseOne)
		compcase.parttype = nil
		assert !compcase.valid?
	end
	
	test "Rejects over length limit parttype" do
	    compcase = cases(:GoodCaseOne)
		compcase.parttype = 'x'*6
		assert !compcase.valid?
	end
	
	test "Rejects non case parttype" do
	    assert !cases(:NonCasePartType).valid?
	end
	
	test "Rejects null manufacturer" do
	    compcase = cases(:GoodCaseOne)
		compcase.manufacturer = nil
		assert !compcase.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    compcase = cases(:GoodCaseOne)
		compcase.manufacturer = 'x'*25
		assert !compcase.valid?
	end
	
	test "Rejects null price" do
	    compcase = cases(:GoodCaseOne)
		compcase.price = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative price" do
	    assert !cases(:NegativePriceCase).valid?
	end
	
	test "Rejects zero price" do
	    assert !cases(:ZeroPriceCase).valid?
	end
	
	test "Rejects null model" do
	    compcase = cases(:GoodCaseOne)
		compcase.model = nil
		assert !compcase.valid?
	end
	
	test "Rejects over length limit model" do
	    compcase = cases(:GoodCaseOne)
		compcase.model = 'x'*35
		assert !compcase.valid?
	end
	
	test "Rejects over length limit series" do
	    compcase = cases(:GoodCaseOne)
		compcase.series = 'x'*35
		assert !compcase.valid?
	end
	
    test "Rejects null manufacturerwebsite" do
	    compcase = cases(:GoodCaseOne)
		compcase.manufacturerwebsite = nil
		assert !compcase.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    compcase = cases(:GoodCaseOne)
		compcase.manufacturerwebsite = 'x'*260
		assert !compcase.valid?
	end
	
	test "Rejects null googleprice" do
	    compcase = cases(:GoodCaseOne)
		compcase.googleprice = nil
		assert !compcase.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    compcase = cases(:GoodCaseOne)
		compcase.googleprice = 'x'*260
		assert !compcase.valid?
	end
	
	test "Rejects null totalbays" do
	    compcase = cases(:GoodCaseOne)
		compcase.totalbays = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative totalbays" do
	    assert !cases(:NegativeTotalBaysCase).valid?
	end
	
	test "Rejects zero totalbays" do
	    assert !cases(:ZeroTotalBaysCase).valid?
	end
	
	test "Rejects null hddbays" do
	    compcase = cases(:GoodCaseOne)
		compcase.hddbays = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative hddbays" do
	    assert !cases(:NegativeHDDBaysCase).valid?
	end
	
	test "Rejects zero hddbays" do
	    assert !cases(:ZeroHDDBaysCase).valid?
	end
	
	test "Rejects null conversionbays" do
	    compcase = cases(:GoodCaseOne)
		compcase.conversionbays = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative conversionbays" do
	    assert !cases(:NegativeConversionBaysCase).valid?
	end
	
	test "Rejects null ssdbays" do
	    compcase = cases(:GoodCaseOne)
		compcase.ssdbays = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative ssdbays" do
	    assert !cases(:NegativeSSDBaysCase).valid?
	end
	
	test "Rejects null expansionslots" do
	    compcase = cases(:GoodCaseOne)
		compcase.expansionslots = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative expansionslots" do
	    assert !cases(:NegativeExpansionSlotsCase).valid?
	end
	
	test "Rejects zero expansionslots" do
	    assert !cases(:ZeroExpansionSlotsCase).valid?
	end
	
	test "Rejects null discbays" do
	    compcase = cases(:GoodCaseOne)
		compcase.discbays = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative discbays" do
	    assert !cases(:NegativeDiscBaysCase).valid?
	end
	
	test "Rejects zero discbays" do
	    assert !cases(:ZeroDiscBaysCase).valid?
	end
	
	test "Rejects null casetype" do
	    compcase = cases(:GoodCaseOne)
		compcase.casetype = nil
		assert !compcase.valid?
	end
	
	test "Rejects over length limit case type" do
	    compcase = cases(:GoodCaseOne)
		compcase.casetype = 'x'*30
		assert !compcase.valid?
	end
	
	test "Rejects null length" do
	    compcase = cases(:GoodCaseOne)
		compcase.length = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative length" do
	    assert !cases(:NegativeLengthCase).valid?
	end
	
	test "Rejects zero length" do
	    assert !cases(:ZeroLengthCase).valid?
	end
	
	test "Rejects null width" do
	    compcase = cases(:GoodCaseOne)
		compcase.width = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative width" do
	    assert !cases(:NegativeWidthCase).valid?
	end
	
	test "Rejects zero width" do
	    assert !cases(:ZeroWidthCase).valid?
	end
	
	test "Rejects null height" do
	    compcase = cases(:GoodCaseOne)
		compcase.height = nil
		assert !compcase.valid?
	end
	
	test "Rejects negative height" do
	    assert !cases(:NegativeHeightCase).valid?
	end
	
	test "Rejects zero height" do
	    assert !cases(:ZeroHeightCase).valid?
	end
end
