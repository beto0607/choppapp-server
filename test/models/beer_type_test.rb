require 'test_helper'

class BeerTypeTest < ActiveSupport::TestCase
  test "Should be valid" do
    assert build(:beer_type).valid?
  end

  test "Should be invalid without name" do
    bt = build(:beer_type, name: nil)
    assert bt.invalid?
  end

  test "Should be invalid without description" do
    bt = build(:beer_type, description: nil)
    assert bt.invalid?
  end

  test "Should be invalid duplication" do
    original = create(:beer_type)
    bt = build(:beer_type, name: original.name)
    assert bt.invalid?
  end
end
