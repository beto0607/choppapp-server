require "test_helper"

class BeersControllerTest < ActionDispatch::IntegrationTest
  # Index
  test "Should get index" do
    get beers_url, as: :json
    assert_response :ok
  end
  
  # Creation
  test "Should create beer" do
    create_producer()
    post beers_url, params: { beer: attributes_for(:beer) }, as: :json, headers: @auth_header
    assert_response :created
  end
  test "Shouldn't create beer without login" do
    post beers_url, params: { beer: attributes_for(:beer) }, as: :json
    assert_response :unauthorized
  end

  # Show
  test "Should show beer" do
    @beer = create(:beer)
    get beer_url(@beer), as: :json
    assert_response :ok
  end
  test "Should return 404" do
    get beer_url(-1), as: :json
    assert_response :not_found
  end

  # Update
  test "Should update beer" do
    create_producer()
    @beer = create(:beer, producer: @producer)
    patch beer_url(@beer), params: { beer: attributes_for(:beer) }, as: :json, headers: @auth_header
    assert_response :ok
  end
  test "Producer must be the owner" do
    create_producer()
    @other_producer = create(:producer)
    @beer = create(:beer, producer: @other_producer)
    patch beer_url(@beer), params: { beer: attributes_for(:beer) }, as: :json, headers: @auth_header
    assert_response :unauthorized
  end
  test "Should return bad_request when called without parameters" do
    create_producer()
    @beer = create(:beer, producer: @other_producer)
    patch beer_url(@beer), params: { beer: nil }, as: :json, headers: @auth_header
    assert_response :bad_request
  end

  # Delete
  test "Should destroy beer" do
    create_producer()
    @beer = create(:beer, producer: @other_producer)
    delete beer_url(@beer), as: :json, headers: @auth_header
    assert_response :no_content
  end
  test "Should return 404" do
    create_producer()
    delete beer_url(-1), as: :json, headers: @auth_header
    assert_response :no_content
  end
  test "Should return 404" do
    create_producer()
    @other_producer = create(:producer)
    @beer = create(:beer, producer: @other_producer)
    delete beer_url(@beer), as: :json, headers: @auth_header
    assert_response :no_content
  end
end
