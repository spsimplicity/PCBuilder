require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "Accepts good User" do
      user = users(:GoodUserOne)
	  user.password = "easypeasy"
      assert user.valid?
	  user = users(:GoodUserTwo)
	  user.password = "easypeasy"
	  assert user.valid?
  end
  
  test "Rejects non-alpha-numeric username" do
      assert !users(:NonAlphaNumericUsername).valid?
  end
  
  test "Rejects over length limit username" do
      user = users(:GoodUserOne)
	  user.name = 'x'*31
	  assert !user.valid?
  end
  
  test "Rejects null username" do
      user = users(:GoodUserOne)
	  user.name = nil
	  assert !user.valid?
	  user.name = ""
	  assert !user.valid?
  end
  
  test "Rejects invalid email address" do
      assert !users(:InvalidEmail).valid?
  end
  
  test "Rejects over length limit email address" do
      user = users(:GoodUserOne)
	  user.email = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx@hotmail.com"
	  assert !user.valid?
  end
  
  test "Rejects null email address" do
      user = users(:GoodUserOne)
	  user.email = nil
	  assert !user.valid?
	  user.email = ""
	  assert !user.valid?
  end
  
  test "Rejects invalid ip address" do
      assert !users(:InvalidIPAddress).valid?
  end
  
  test "Rejects null ip address" do
      user = users(:GoodUserOne)
	  user.ip = nil
	  assert !user.valid?
	  user.ip = ""
	  assert !user.valid?
  end
      
  test "Rejects an over length limit password" do
      user = users(:GoodUserOne)
	  user.password = 'x'*51
	  assert !user.valid?
  end
  
  test "Rejects null password" do
      user = users(:GoodUserOne)
	  user.password = nil
	  assert !user.valid?
	  user.password = nil
	  assert !user.valid?
  end
  
  test "Rejects non-matching password confirmation" do
      user = users(:GoodUserOne)
	  user.password = "easypeasy"
	  user.password_confirmation = "changeme"
	  assert !user.valid?
  end
  
  test "Encrypted password still matches original word when encrypted" do
      user = users(:GoodUserOne)
	  user.password = "easypeasy"
	  user.save
      assert user.has_password?("easypeasy")
  end  
end
