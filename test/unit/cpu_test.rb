require 'test_helper'

class CpuTest < ActiveSupport::TestCase
  
  test "Accepts good Cpus" do
      assert cpus(:GoodCpuOne).valid?
	  assert cpus(:GoodCpuTwo).valid?
  end
  
  test "Rejects null type value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.parttype = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over length limit type value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.parttype = 'x'*15
	  assert !cpu.valid?
  end
  
  test "Rejects non 'cpu' value for type" do
      assert !cpus(:NonCpuType).valid?
  end
  
  test "Rejects null model value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.model = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over length limit model value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.model = 'x'*15
	  assert !cpu.valid?
  end
  
  test "Rejects null manufacturer value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.manufacturer = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over length limit manufacturer value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.manufacturer = 'x'*15
	  assert !cpu.valid?
  end
  
  test "Rejects over length limit series value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.series = 'x'*35
	  assert !cpu.valid?
  end
  
  test "Rejects null price value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.price = nil
	  assert !cpu.valid?
  end
  
  test "Rejects negative price value" do
      assert !cpus(:NegativeCpuPrice).valid?
  end
  
  test "Rejects zero price value" do
      assert !cpus(:ZeroCpuPrice).valid?
  end
  
  test "Rejects null manufacturer website value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.manufacturerwebsite = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over 255 character man website value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.manufacturerwebsite = 'x'*260
	  assert !cpu.valid?
  end
  
  test "Rejects null googleprice value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.googleprice = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over 255 character googleprice value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.googleprice = 'x'*260
	  assert !cpu.valid?
  end
  
  test "Rejects null frequency value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.frequency = nil
	  assert !cpu.valid?
  end
  
  test "Rejects zero frequency value" do
      assert !cpus(:ZeroCpuFrequency).valid?
  end
  
  test "Rejects negative frequency value" do
      assert !cpus(:NegativeCpuFrequency).valid?
  end
  
  test "Rejects null sockettype value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.sockettype = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over length limit sockettype value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.sockettype = 'x'*20
	  assert !cpu.valid?
  end
  
  test "Rejects null fsb value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.fsb = nil
	  assert !cpu.valid?
  end
  
  test "Rejects zero fsb value" do
      assert !cpus(:ZeroCpuFsb).valid?
  end
  
  test "Rejects negative fsb value" do
      assert !cpus(:NegativeCpuFsb).valid?
  end
  
  test "Rejects negative l1cache value" do
      assert !cpus(:NegativeCpuL1Cache).valid?
  end
  
  test "Rejects negative l2cache value" do
      assert !cpus(:NegativeCpuL2Cache).valid?
  end
  
  test "Rejects negative l3cache value" do
      assert !cpus(:NegativeCpuL3Cache).valid?
  end
  
  test "Rejects null cores value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.cores = nil
	  assert !cpu.valid?
  end
  
  test "Rejects negative cores value" do
      assert !cpus(:NegativeCpuCores).valid?
  end
  
  test "Rejects zero cores value" do
      assert !cpus(:ZeroCpuCores).valid?
  end
  
  test "Rejects null watts value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.watts = nil
	  assert !cpu.valid?
  end
  
  test "Rejects zero watts value" do
      assert !cpus(:ZeroCpuWatts).valid?
  end
  
  test "Rejects negative watts value" do
      assert !cpus(:NegativeCpuWatts).valid?
  end
  
  test "Rejects null powerpin value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.powerpin = nil
	  assert !cpu.valid?
  end
  
  test "Rejects zero powerpin value" do
      assert !cpus(:ZeroCpuPowerPin).valid?
  end
  
  test "Rejects negative powerpin value" do
      assert !cpus(:NegativeCpuPowerPin).valid?
  end
  
  test "Rejects negative maxmemory value" do
      assert !cpus(:NegativeCpuMaxMemory).valid?
  end
  
  test "Rejects zero maxmemory value" do
      assert !cpus(:ZeroCpuMaxMemory).valid?
  end
  
  test "Rejects null maxmemory value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.maxmemory = nil
	  assert !cpu.valid?
  end
  
  test "Rejects negative memchanneltype value" do
      assert !cpus(:NegativeCpuMemChannelType).valid?
  end
  
  test "Rejects zero memchanneltype value" do
      assert !cpus(:ZeroCpuMemChannelType).valid?
  end
  
  test "Rejects null memchanneltype value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.memchanneltype = nil
	  assert !cpu.valid?
  end
  
  test "Rejects null part_id" do
      cpu = cpus(:GoodCpuOne)
	  cpu.part_id = nil
	  assert !cpu.valid?
  end
  
  test "Rejects negative part_id" do
      assert !cpus(:NegativeCpuPartId).valid?
  end
  
  test "Rejects zero part_id" do
      assert !cpus(:ZeroCpuPartId).valid?
  end
  
  test "Rejects non existant part_id" do
      assert !cpus(:NonExistantCpuPartId).valid?
  end
end
