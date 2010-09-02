require 'test_helper'

class ComputerTest < ActiveSupport::TestCase

    test "Accepts a good computer" do
	    assert computers(:GoodComputerOne).valid?
		assert computers(:GoodComputerTwo).valid?
    end
	
	test "Default name is Custom Built Computer" do
	    assert computers(:BlankNameComputer).name == "Custom Built Computer"
	end
  
    test "Rejects a zero or less motherboard id" do
	    assert !computers(:NegativeMotherboardId).valid?
		assert !computers(:ZeroMotherboardId).valid?
    end
  
    test "Rejects a null motherboard id" do
	    comp = computers(:GoodComputerOne)
		comp.motherboard_id = nil
		assert !comp.valid?
    end
	
	test "Rejects a non-existant motherboard id" do
	    assert !computers(:NonExistantMoboId).valid?
	end

    test "Rejects a zero or less cpu id" do
	    assert !computers(:NegativeCpuId).valid?
		assert !computers(:ZeroCpuId).valid?
	end
	
	test "Rejects a null cpu id" do
	    comp = computers(:GoodComputerOne)
		comp.cpu_id = nil
		assert !comp.valid?
	end
	
	test "Rejects a non-existant cpu id" do
	    assert !computers(:NonExistantCpuId).valid?
	end
	
	test "Rejects a zero or less cpu fan id" do
	    assert !computers(:NegativeCpuFanId).valid?
		assert !computers(:ZeroCpuFanId).valid?
	end
	
	test "Rejects a null cpu fan id" do
	    comp = computers(:GoodComputerOne)
		comp.cpu_cooler_id = nil
		assert !comp.valid?
	end
	
	test "Rejects a non-existant cpufan id" do
	    assert !computers(:NonExistantCpuFanId).valid?
	end
	
	test "Rejects a zero or less power supply id" do
	    assert !computers(:NegativePowerSupplyId).valid?
		assert !computers(:ZeroPowerSupplyId).valid?
	end
	
	test "Rejects a null power supply id" do
	    comp = computers(:GoodComputerOne)
		comp.power_supply_id = nil
		assert !comp.valid?
	end
	
	test "Rejects a non-existant power supply id" do
	    assert !computers(:NonExistantPowerSupplyId).valid?
	end
	
	test "Rejects a zero or less case id" do
	    assert !computers(:NegativeCaseId).valid?
		assert !computers(:ZeroCaseId).valid?
	end
	
	test "Rejects a null case id" do
	    comp = computers(:GoodComputerOne)
		comp.case_id = nil
		assert !comp.valid?
	end
	
	test "Rejects a non-existant case id" do
	    assert !computers(:NonExistantCaseId).valid?
	end
	
	test "Rejects an over length limit name" do
	    comp = computers(:GoodComputerOne)
		comp.name = 'x'*51
		assert !comp.valid?
	end
	
	test "Rejects a zero or less user id" do
	    comp = computers(:GoodComputerOne)
		comp.user_id = -1
		assert !comp.valid?
	end
	
	test "Rejects a null user id" do
	    comp = computers(:GoodComputerOne)
		comp.user_id = nil
		assert !comp.valid?
	end
	
	test "Rejects a non-existant user id" do
	    assert !computers(:NonExistantUserId).valid?
	end
end
