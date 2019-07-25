require "test_helper"

class VoteTest < ActiveSupport::TestCase
  test "Should be valid" do
    assert build(:vote).valid?
  end

  test "Should be invalid duplicated vote(same beer, same user)" do
    user = create(:user)
    beer = create(:beer)
    vote = create(:vote, user: user, beer: beer)
    assert build(:vote, user: user, beer: beer).invalid?
  end

  test "Should be invalid score must be greater or equal than 0" do
    assert build(:vote, score: -1).invalid?
  end

  test "Should be invalid score must be lesser or equal than 5" do
    assert build(:vote, score: 10).invalid?
  end

  test "Should be invalid when user's status is BLOCKED" do
    user = create(:user, status: 'BLOCKED')
    assert build(:vote, user:user).invalid?
  end

  test "Should be invalid without beer" do
    assert build(:vote, beer: nil).invalid?
  end

  test "Should be invalid without user" do
    assert build(:vote, beer: nil).invalid?
  end
end
