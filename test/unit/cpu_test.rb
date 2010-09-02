require 'test_helper'

class CpuTest < ActiveSupport::TestCase
  
  test "Accepts good Cpus" do
      assert cpus(:GoodCpuOne).valid?
	  assert cpus(:GoodCpuTwo).valid?
  end
  
  test "Rejects null type value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.type = nil
	  assert !cpu.valid?
  end
  
  test "Rejects over length limit type value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.type = 'x'*15
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
      assert !(:NegativeCpuPrice).valid?
  end
  
  test "Rejects zero price value" do
      assert !(:ZeroCpuPrice).valid?
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
      assert !(:ZeroCpuFrequency).valid?
  end
  
  test "Rejects negative frequency value" do
      assert !(:NegativeCpuFrequency).valid?
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
  
  test "Rejects negative l1cache value" do
      assert !(:NegativeCpuL1Cache).valid?
  end
  
  test "Rejects negative l2cache value" do
      assert !(:NegativeCpuL2Cache).valid?
  end
  
  test "Rejects negative l3cache value" do
      assert !(:NegativeCpuL3Cache).valid?
  end
  
  test "Rejects null cores value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.cores = nil
	  assert !cpu.valid?
  end
  
  test "Rejects negative cores value" do
      assert !(:NegativeCpuCores).valid?
  end
  
  test "Rejects zero cores value" do
      assert !(:ZeroCpuCores).valid?
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
      asert !cpus(:NegativeCpuPowerPin).valid?
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
      assert !cpus(:NegativeMemChannelType).valid?
  end
  
  test "Rejects zero memchanneltype value" do
      assert !cpus(:ZeroMemChannelType).valid?
  end
  
  test "Rejects null memchanneltype value" do
      cpu = cpus(:GoodCpuOne)
	  cpu.memchanneltype = nil
	  assert !cpu.valid?
  end
end
