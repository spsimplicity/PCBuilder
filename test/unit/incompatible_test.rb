require 'test_helper'

class IncompatibleTest < ActiveSupport::TestCase
  
    test "Accepts good incompatibilities" do
	    assert incompatibles(:GoodIncompatibilityOne).valid?
		assert incompatibles(:GoodIncompatibilityTwo).valid?
	end
	
	test "Rejects null part1_id" do
	    inc = incompatibles(:GoodIncompatibilityTwo)
		inc.part1_id = nil
		assert !inc.valid?
	end
	
	test "Rejects negative part1_id" do
	    assert !incompatibles(:NegativePart1Incompatibility).valid?
	end
	
	test "Rejects zero part1_id" do
	    assert !incompatibles(:ZeroPart1Incompatibility).valid?
	end
	
	test "Rejects non existant part1_id" do
	    assert !incompatibles(:NonExistantPart1Incompatibility).valid?
	end
	
	test "Rejects null part2_id" do
	    inc = incompatibles(:GoodIncompatibilityTwo)
		inc.part2_id = nil
		assert !inc.valid?
	end
	
	test "Rejects negative part2_id" do
	    assert !incompatibles(:NegativePart2Incompatibility).valid?
	end
	
	test "Rejects zero part2_id" do
	    assert !incompatibles(:ZeroPart2Incompatibility).valid?
	end
	
	test "Rejects non existant part2_id" do
	    assert !incompatibles(:NonExistantPart2Incompatibility).valid?
	end
	
	test "Rejects null part1type" do
	    inc = incompatibles(:GoodIncompatibilityTwo)
		inc.part1type = nil
		assert !inc.valid?
	end
	
	test "Rejects over length limit part1type" do
	    inc = incompatibles(:GoodIncompatibilityTwo)
		inc.part1type = 'x'*25
		assert !inc.valid?
	end
	
	test "Rejects not supported part1type" do
	    assert !incompatibles(:NonSupportedPart1TypeIncompatibility).valid?
	end
	
	test "Rejects null part2type" do
	    inc = incompatibles(:GoodIncompatibilityTwo)
		inc.part2type = nil
		assert !inc.valid?
	end
	
	test "Rejects over length limit part2type" do
	    inc = incompatibles(:GoodIncompatibilityTwo)
		inc.part2type = 'x'*25
		assert !inc.valid?
	end
	
	test "Rejects not supported part2type" do
	    assert !incompatibles(:NonSupportedPart2TypeIncompatibility).valid?
	end
end
