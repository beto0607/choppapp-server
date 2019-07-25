require 'test_helper'

class BeerTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, is_admin: true)
    @auth_header = { Authorization: "Bearer #{JsonWebToken.encode(user_id: @user.id)}" }
    @beer_type = create(:beer_type)
  end

  test "should get index" do
    get beer_types_url, as: :json
    assert_response :success
  end

  test "should create beer_type" do
    assert_difference('BeerType.count') do
      post beer_types_url, params: { beer_type: attributes_for(:beer_type) }, as: :json, headers: @auth_header
    end
    assert_response 201
  end

  test "should show beer_type" do
    get beer_type_url(@beer_type), as: :json
    assert_response :success
  end

  test "should get all beer from a beer_type" do
    get beer_type_url(@beer_type), as: :json
    assert_response :success
    assert_equal @beer_type.beers.count, response.parsed_body.beers.count
  end

  test "should destroy beer_type" do
    assert_difference('BeerType.count', -1) do
      delete beer_type_url(@beer_type), as: :json, headers: @auth_header
    end
    assert_response 204
  end
end
