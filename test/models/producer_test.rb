require "test_helper"

class ProducerTest < ActiveSupport::TestCase
  test "Should be valid" do
    assert build(:producer).valid?
  end

  test "Should be invalid when user's status it's BLOCKED" do
    user = create(:user, status: "BLOCKED")
    assert build(:producer, user: user).invalid?
  end

  test "Status should be PENDING when created" do
    assert_equal create(:producer).status, "PENDING"
  end

  test "Should be invalid without user" do
    assert build(:producer, user: nil).invalid?
  end

  test "Should be invalid without name" do
    assert build(:producer, name: nil).invalid?
  end

  test "Should be invalid without description" do
    assert build(:producer, description: nil).invalid?
  end

  test "Should be invalid duplicated name" do
    original = create(:producer)
    assert build(:producer, name: original.name).invalid?
  end
end
