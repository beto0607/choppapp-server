require "test_helper"

class BeerTypesControllerTest < ActionDispatch::IntegrationTest
  # Index
  test "should get index" do
    get beer_types_url, as: :json
    assert_response :success
  end
  test "should get all beer from a beer_type" do
    @beer_type = create(:beer_type)
    @beer = create(:beer, beer_type: @beer_type)
    get beer_type_url(@beer_type), as: :json
    assert_response :success
    assert_equal @beer_type.beers.count, response.parsed_body.beers.count
  end

  # Creation
  test "should create beer_type" do
    createAdmin()
    post beer_types_url, params: { beer_type: attributes_for(:beer_type) }, as: :json, headers: @auth_header
    assert_response 201
  end

  # Delete
  test "should destroy beer_type" do
    createAdmin()
    @beer_type = create(:beer_type)
    delete beer_type_url(@beer_type), as: :json, headers: @auth_header
    assert_response :no_content
    assert @beer_type.destroyed?
  end
end
