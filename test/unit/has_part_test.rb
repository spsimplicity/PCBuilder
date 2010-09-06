require 'test_helper'

class HasPartTest < ActiveSupport::TestCase
  
    test "Accepts good has_parts" do
	    assert has_parts(:GoodHasPartOne).valid?
		assert has_parts(:GoodHasPartTwo).valid?
	end
	
	test "Rejects null computer_id" do
	    hasPart = has_parts(:GoodHasPartOne)
		hasPart.computer_id = nil
		assert !hasPart.valid?
	end
	
	test "Rejects negative computer_id" do
	    assert !has_parts(:NegativeComputerIdHasPart).valid?
	end
	
	test "Rejects zero computer_id" do
	    assert !has_parts(:ZeroComputerIdHasPart).valid?
	end
	
	test "Rejects non existant computer_id" do
	    assert !has_parts(:NonExistantComputerIdHasPart).valid?
	end
	
	test "Rejects null part_id" do
	    hasPart = has_parts(:GoodHasPartOne)
		hasPart.part_id = nil
		assert !hasPart.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !has_parts(:NegativePartIdHasPart).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !has_parts(:ZeroPartIdHasPart).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !has_parts(:NonExistantPartIdHasPart).valid?
	end
	
	test "Rejects null parttype" do
	    hasPart = has_parts(:GoodHasPartOne)
		hasPart.parttype = nil
		assert !hasPart.valid?
	end
	
	test "Rejects over length limit parttype" do
	    hasPart = has_parts(:GoodHasPartOne)
		hasPart.parttype = 'x'*25
		assert !hasPart.valid?
	end
end
