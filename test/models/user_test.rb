require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should be valid" do
    assert build(:user).valid?
  end

  test "Status should be ACTIVE when created" do
    assert_equal create(:user).status, "ACTIVE"
  end
  
  test "Should be invalid duplicated email" do
    original = create(:user)
    assert build(:user, email: original.email).invalid?
  end

  test "Should be invalid without email" do
    assert build(:user, email: nil).invalid?
  end

  test "Should be invalid without password" do
    assert build(:user, password_digest: nil).invalid?
  end
end
