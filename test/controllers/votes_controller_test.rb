require "test_helper"

class VotesControllerTest < ActionDispatch::IntegrationTest
  # Index
  test "Should get index by beer_id" do
    @beer = create(:beer)
    @votes = create(:votes, beer: @beer)
    get beer_votes_url(@beer), as: :json
    assert_response :ok
  end
  test "Should get index by user_id" do
    @user = create(:user)
    @votes = create(:votes, user: @user)
    get user_votes_url(@user), as: :json
    assert_response :ok
  end
  test "Should get index by producer_id" do
    @producer = create(:producer)
    @beer = create(:beer, producer: @producer)
    @votes = create(:votes, user: @user)
    get producer_votes_url(@producer), as: :json
    assert_response :ok
  end
  # Show
  test "should show vote" do
    @vote = create(:vote)
    get vote_url(@vote), as: :json
    assert_response :success
  end
  test "Should return 404" do
    get vote_url(-1), as: :json
    assert_response :not_found
  end

  # Creation
  test "should create vote" do
    create_auth_header()
    post votes_url, params: { vote: attribute_for(:vote) }, as: :json, headers: @auth_header
    assert_response :created
  end
  test "Shouldn't create vote without attributes" do
    create_auth_header()
    post votes_url, params: { vote: nil }, as: :json, headers: @auth_header
    assert_response :bad_request
  end
  test "Shouldn't create vote without a user logged in" do
    post votes_url, params: { vote: attribute_for(:vote) }, as: :json    
    assert_response :unauthorized
  end

  # Update
  test "should update vote" do
    create_auth_header()
    @vote = create(:vote, user: @user)
    patch vote_url(@vote), params: { vote: attribute_for(:vote) }, as: :json, headers: @auth_header
    assert_response :ok
  end
  test "Should return 404 - update" do
    create_auth_header()
    patch vote_url(-1), params: { vote: nil }, as: :json, headers: @auth_header
    assert_response :not_found
  end
  test "Shouldn't update vote without attributes" do
    create_auth_header()
    @vote = create(:vote, user: @user)
    patch vote_url(@vote), params: { vote: nil }, as: :json, headers: @auth_header
    assert_response :bad_request
  end
  test "Shouldn't update vote without a user logged in" do
    @vote = create(:vote)
    patch vote_url(@vote), params: { vote: attribute_for(:vote) }, as: :json    
    assert_response :unauthorized
  end

  # Delete
  test "should destroy vote" do
    create_auth_header()
    @vote = cerate(:vote, user: @user)
    delete vote_url(@vote), as: :json, headers: @auth_header
    assert_response :no_content
  end
  test "Shouldn't delete vote without a user logged in" do
    delete votes_url, params: { vote: attribute_for(:vote) }, as: :json    
    assert_response :unauthorized
  end
  test "Should return 404 - delete" do
    create_auth_header()
    delete vote_url(-1), params: { vote: nil }, as: :json, headers: @auth_header
    assert_response :not_found
  end
end
