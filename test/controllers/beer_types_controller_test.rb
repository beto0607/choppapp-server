require 'test_helper'

class BeerTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beer_type = beer_types(:one)
  end

  test "should get index" do
    get beer_types_url, as: :json
    assert_response :success
  end

  test "should create beer_type" do
    assert_difference('BeerType.count') do
      post beer_types_url, params: { beer_type: { description: @beer_type.description, name: @beer_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show beer_type" do
    get beer_type_url(@beer_type), as: :json
    assert_response :success
  end

  test "should update beer_type" do
    patch beer_type_url(@beer_type), params: { beer_type: { description: @beer_type.description, name: @beer_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy beer_type" do
    assert_difference('BeerType.count', -1) do
      delete beer_type_url(@beer_type), as: :json
    end

    assert_response 204
  end
end
