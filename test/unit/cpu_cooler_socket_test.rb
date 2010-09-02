require 'test_helper'

class CpuCoolerSocketTest < ActiveSupport::TestCase

  test "Accepts good cooler sockets" do
        assert cpu_cooler_sockets(:GoodSocketOne).valid?
		assert cpu_cooler_sockets(:GoodSocketTwo).valid?
    end
	
	test "Rejects a zero or less cpu_cooler id" do
	    assert !cpu_cooler_sockets(:CoolerIdNegative).valid?
		assert !cpu_cooler_sockets(:CoolerIdZero).valid?
	end
	
	test "Rejects a null cpu_cooler id" do
	    cooler = cpu_cooler_sockets(:GoodSocketOne)
		cooler.cpu_cooler = nil
		assert !cooler.valid?
	end
	
	test "Rejects a null sockettype" do
	    cooler = cpu_cooler_sockets(:GoodSocketOne)
		cooler.sockettype = nil
		assert !cooler.valid?
	end
	
	test "Rejects a un-used sockettype" do
	    assert !cpu_cooler_sockets(:SocketTypeNotUsed).valid?
	end
	
	test "Rejects over limit sockettype" do
	    cooler = cpu_cooler_sockets(:GoodSocketOne)
		cooler.sockettype = 'x'*15
		assert !cooler.valid?
	end
	
	test "Rejects non-existant cpu_cooler id" do
	    assert !cpu_cooler_sockets(:CoolerIdNonExistant).valid?
	end
end
