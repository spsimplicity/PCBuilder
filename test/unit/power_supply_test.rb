require 'test_helper'

class PowerSupplyTest < ActiveSupport::TestCase
  
    test "Accepts good power supplies" do
	    assert power_supplies(:GoodPowerSupplyOne).valid?
		assert power_supplies(:GoodPowerSupplyTwo).valid?
	end
	
	test "Rejects null parttype" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.parttype = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit parttype" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.parttype = 'x'*25
		assert !power.valid?
	end
	
	test "Rejects non power supply partype" do
	    assert !power_supplies(:NonPowerSupplyPartType).valid?
	end
	
	test "Rejects null manufacturer" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.manufacturer = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit manufacturer" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.manufacturer = 'x'*35
		assert !power.valid?
	end
	
	test "Rejects null manufacturerwebsite" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.manufacturerwebsite = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit manufacturerwebsite" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.manufacturerwebsite = 'x'*260
		assert !power.valid?
	end
	
	test "Rejects null googleprice" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.googleprice = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit googleprice" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.googleprice = 'x'*260
		assert !power.valid?
	end
	
	test "Rejects null price" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.price = nil
		assert !power.valid?
	end
	
	test "Rejects negative price" do
	    assert !power_supplies(:NegativePricePowerSupply).valid?
	end
	
	test "Rejects zero price" do
	    assert !power_supplies(:ZeroPricePowerSupply).valid?
	end
	
	test "Rejects null model" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.model = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit model" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.model = 'x'*35
		assert !power.valid?
	end
	
	test "Rejects null series" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.series = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit series" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.series = 'x'*35
		assert !power.valid?
	end
	
	test "Rejects null fansize" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.fansize = nil
		assert !power.valid?
	end
	
	test "Rejects negative fansize" do
	    assert !power_supplies(:NegativeFanSizePowerSupply).valid?
	end
	
	test "Rejects zero fansize" do
	    assert !power_supplies(:ZeroFanSizePowerSupply).valid?
	end
	
	test "Rejects null mainpower" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.mainpower = nil
		assert !power.valid?
	end
	
	test "Rejects negative mainpower" do
	    assert !power_supplies(:NegativeMainPowerPowerSupply).valid?
	end
	
	test "Rejects zero mainpower" do
	    assert !power_supplies(:ZeroMainPowerPowerSupply).valid?
	end
	
	test "Rejects null satapower" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.satapower = nil
		assert !power.valid?
	end
	
	test "Rejects negative satapower" do
	    assert !power_supplies(:NegativeSataPowerPowerSupply).valid?
	end
	
	test "Rejects null multi_gpu" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.multi_gpu = nil
		assert !power.valid?
	end
	
	test "Rejects null peripheral" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.peripheral = nil
		assert !power.valid?
	end
	
	test "Rejects negative peripheral" do
	    assert !power_supplies(:NegativePeripheralPowerSupply).valid?
	end
	
	test "Rejects over length limit energycert" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.energycert = 'x'*25
		assert !power.valid?
	end
	
	test "Rejects null power_supply_type" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.power_supply_type = nil
		assert !power.valid?
	end
	
	test "Rejects over length limit power_supply_type" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.power_supply_type = 'x'*45
		assert !power.valid?
	end
	
	test "Rejects null poweroutput" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.poweroutput = nil
		assert !power.valid?
	end
	
	test "Rejects negative poweroutput" do
	    assert !power_supplies(:NegativePowerOutputPowerSupply).valid?
	end
	
	test "Rejects zero poweroutput" do
	    assert !power_supplies(:ZeroPowerOutputPowerSupply).valid?
	end
	
	test "Rejects null cpu4_4pin" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.cpu4_4pin = nil
		assert !power.valid?
	end
	
	test "Rejects negative cpu4_4pin" do
	    assert !power_supplies(:NegativeCpu4_4PinPowerSupply).valid?
	end
	
	test "Rejects null cpu4pin" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.cpu4pin = nil
		assert !power.valid?
	end
	
	test "Rejects negative cpu4pin" do
	    assert !power_supplies(:NegativeCpu4PinPowerSupply).valid?
	end
	
	test "Rejects null cpu8pin" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.cpu8pin = nil
		assert !power.valid?
	end
	
	test "Rejects negative cpu8pin" do
	    assert !power_supplies(:NegativeCpu8PinPowerSupply).valid?
	end
	
	test "Rejects null gpu8pin" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.gpu8pin = nil
		assert !power.valid?
	end
	
	test "Rejects negative gpu8pin" do
	    assert !power_supplies(:NegativeGpu8PinPowerSupply).valid?
	end
	
	test "Rejects null gpu6pin" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.gpu6pin = nil
		assert !power.valid?
	end
	
	test "Rejects negative gpu6pin" do
	    assert !power_supplies(:NegativeGpu6PinPowerSupply).valid?
	end
	
	test "Rejects null gpu6_2pin" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.gpu6_2pin = nil
		assert !power.valid?
	end
	
	test "Rejects negative gpu6_2pin" do
	    assert !power_supplies(:NegativeGpu6_2PinPowerSupply).valid?
	end
	
	test "Rejects null length" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.length = nil
		assert !power.valid?
	end
	
	test "Rejects negative length" do
	    assert !power_supplies(:NegativeLengthPowerSupply).valid?
	end
	
	test "Rejecte zero length" do
	    assert !power_supplies(:ZeroLengthPowerSupply).valid?
	end
	
	test "Rejects null part_id" do
	    power = power_supplies(:GoodPowerSupplyOne)
		power.part_id = nil
		assert !power.valid?
	end
	
	test "Rejects negative part_id" do
	    assert !power_supplies(:NegativePartIdPowerSupply).valid?
	end
	
	test "Rejects zero part_id" do
	    assert !power_supplies(:ZeroPartIdPowerSupply).valid?
	end
	
	test "Rejects non existant part_id" do
	    assert !power_supplies(:NonExistantPartIdPowerSupply).valid?
	end
end
