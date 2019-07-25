require "test_helper"

class BeerTest < ActiveSupport::TestCase
  test "Should be valid" do
    assert build(:beer).valid?
  end

  test "Should be invalid without name" do
    b = build(:beer, name: nil)
    assert b.invalid?
  end

  test "Should be invalid without description" do
    b = build(:beer, description: nil)
    assert b.invalid?
  end

  test "Should be invalid without producer" do
    b = build(:beer, producer: nil)
    assert b.invalid?
  end

  test "Should be invalid without beer type" do
    b = build(:beer, beer_type: nil)
    assert b.invalid?
  end

  test "Should be invalid producer it's blocked" do
    p = create(:producer, status: 'BLOCKED')
    b = build(:beer, producer: p)
    assert b.invalid?
  end
end
