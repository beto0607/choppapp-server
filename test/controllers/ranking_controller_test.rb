require "test_helper"

class RankingControllerTest < ActionDispatch::IntegrationTest
  # Index
  test "Should get Ranking" do
    skip()
    @beer1 = create(:beer, name: '1st position')
    @vote1 = create(:vote, beer: @beer1, score: 5)
    @beer2 = create(:beer, name: '2nd position')
    @vote2 = create(:vote, beer: @beer2, score: 2)
    get ranking_url(), as: :json
    assert_response :ok
  end
  test "Should get Ranking by BeerType" do
    skip()
    @beer_type = create(:beer_type)
    @beer1 = create(:beer, name: '1st position', beer_type: @beer_type)
    @beer2 = create(:beer, name: '2nd position', beer_type: @beer_type)
    @vote1 = create(:vote, beer: @beer1, score: 5)
    @vote2 = create(:vote, beer: @beer2, score: 2)
    p beer_type_ranking_url(@beer_type)
    get beer_type_ranking_url(@beer_type), as: :json
    assert_response :ok
  end
end
