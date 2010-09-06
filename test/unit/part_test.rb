require 'test_helper'

class PartTest < ActiveSupport::TestCase
  
    test "Accepts good parts" do
	    assert parts(:GoodPartOne).valid?
	    assert parts(:GoodPartTwo).valid?
	    assert parts(:GoodPartThree).valid?
	    assert parts(:GoodPartFour).valid?
	    assert parts(:GoodPartFive).valid?
	    assert parts(:GoodPartSix).valid?
	    assert parts(:GoodPartSeven).valid?
	    assert parts(:GoodPartEight).valid?
	    assert parts(:GoodPartNine).valid?
	    assert parts(:GoodPartTen).valid?
	end
	
	test "Rejects null parttype" do
	    part = parts(:GoodPartOne)
		part.parttype = nil
		assert !part.valid?
	end
	
	test "Rejects over lenght limit parttype" do
	    part = parts(:GoodPartOne)
		part.parttype = 'x'*25
		assert !part.valid?
	end
	
	test "Rejects not accepted parttype" do
	    assert !parts(:NotAcceptedPartTypePart).valid?
	end
end
