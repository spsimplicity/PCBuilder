require 'test_helper'

class CaseMotherboardTest < ActiveSupport::TestCase
  
    test "Accepts good case motherboards" do
	    assert case_motherboards(:GoodCaseMotherboardOne).valid?
		assert case_motherboards(:GoodCaseMotherboardTwo).valid?
	end
	
	test "Rejects null case id" do
	    casemobo = case_motherboards(:GoodCaseMotherboardOne)
		casemobo.case_id = nil
		assert !casemobo.valid?
	end
	
	test "Rejects negative case id" do
	    assert !case_motherboards(:NegativeCaseIdCaseMotherboard).valid?
	end
	
	test "Rejects zero case id" do
	    assert !case_motherboards(:ZeroCaseIdCaseMotherboard).valid?
	end

    test "Rejects non existant case id" do
	    assert !case_motherboards(:NonExistantCaseIdCaseMotherboard).valid?
	end
	
	test "Rejects null size" do
	    casemobo = case_motherboards(:GoodCaseMotherboardOne)
		casemobo.size = nil
		assert !casemobo.valid?
	end
	
	test "Rejects over length limit size" do
	    casemobo = case_motherboards(:GoodCaseMotherboardOne)
		casemobo.size = 'x'*20
		assert !casemobo.valid?
	end
	
	test "Rejects non standard size" do
	    assert !case_motherboards(:NonStandardSizeCaseMotherboard).valid?
	end
end
