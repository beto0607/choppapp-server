require "test_helper"

class ProducersControllerTest < ActionDispatch::IntegrationTest
  # Index
  test "Should get all the producers" do
    create(:producer).block()
    create(:producer).active()
    get producers_url + "/all", as: :json
    assert_response :success
  end
  test "Should get all the blocked producers" do
    create(:producer).block()
    get producers_url + "/blocked", as: :json
    assert_response :success
    assert (response.parsed_body.producers.reduce(true) { |ret,  each| ret && each == "BLOCKED" })
  end
  test "Should get all the active producers" do
    create(:producer).active()
    get producers_url, as: :json
    assert_response :success
    assert (response.parsed_body.producers.reduce(true) { |ret,  each| ret && each == "ACTIVE" })
  end
  # Show
  test "Should show producer" do
    @producer = create(:producer)
    get producer_url(@producer), as: :json
    assert_response :success
  end
  test "Should return NOT FOUND on show" do
    get producer_url(-1), as: :json
    assert_response :not_found
  end
  # Creation
  test "Should create producer" do
    create_auth_header()
    post producers_url, params: { producer: attributes_for(:producer) }, as: :json, header: @auth_header
    assert_response :created
  end
  test "Shouldn't create producer whithout user logged in" do
    post producers_url, params: { producer: attributes_for(:producer) }, as: :json
    assert_response :unauthorized
  end
  test "Shouldn't create producer whithout parameteres" do
    create_auth_header()
    post producers_url, params: { producer: nil }, as: :json, header: @auth_header
    assert_response :bad_request
  end
  test "Shouldn't create 2 producers with one user" do
    create_producer()
    post producers_url, params: { producer: attributes_for(:producer) }, as: :json, header: @auth_header
    assert_response :conflict
  end
  test "Shouldn't create 2 producers with the same name" do
    create_producer()
    post producers_url, params: { producer: attributes_for(:producer, name: @producer.name) }, as: :json, header: @auth_header
    assert_response :conflict
  end
  # Update
  test "Should update producer" do
    create_producer()
    patch producer_url(@producer), params: { producer: attributes_for(:producer) }, as: :json, header: @auth_header
    assert_response :ok
  end
  test "Shouldn't update producer without login" do
    create_producer()
    patch producer_url(@producer), params: { producer: attributes_for(:producer) }, as: :json
    assert_response :unauthorized
  end
  test "Shouldn't update other user's producer" do
    @other_producer = create(:producer)
    create_producer()
    patch producer_url(@other_producer), params: { producer: attributes_for(:producer) }, as: :json, header: @auth_header
    assert_response :unauthorized
  end
  test "Shouldn't update producer with duplicated name" do
    create_producer()
    patch producer_url(@producer), params: { producer: attributes_for(:producer, name: @producer.name) }, as: :json, header: @auth_header
    assert_response :conflict
  end
  test "Shouldn't update producer without parameters" do
    create_producer()
    patch producer_url(@producer), params: { producer: nil }, as: :json, header: @auth_header
    assert_response :ok
  end
  # Active
  test "Admin can active a producer" do
    create_producer()
    create_admin()
    patch producer_url(@producer) + "/active", as: :json, header: @auth_header
    assert_response :ok
    assert_equal @producer.status, "ACTIVE"
  end
  # Block
  test "Admin can block a producer" do
    create_producer()
    create_admin()
    patch producer_url(@producer) + "/block", as: :json, header: @auth_header
    assert_response :ok
    assert_equal @producer.status, "BLOCKED"
  end
  # Delete
  test "Should destroy producer" do
    create_producer()
    delete producer_url(@producer), as: :json, header: @auth_header
    assert_response :no_content
    assert @producer.destroyed?
  end
  test "Should destroy producer and beers" do
    create_producer()
    @beer = create(:beer, producer: @producer)
    delete producer_url(@producer), as: :json, header: @auth_header
    assert_response :no_content
    assert @producer.destroyed?
    assert @beer.destroyed?
  end
  test "Should return NOT FOUND on delete" do
    create_producer()
    delete producer_url(-1), as: :json, header: @auth_header
    assert_response :not_found
  end
  test "Shouldn't destroy producer without user logged in" do
    create_producer()
    delete producer_url(@producer), as: :json
    assert_response :unauthorized
  end
  test "Shouldn't destroy other user's producer" do
    @other_producer = create(:producer)
    create_producer()
    delete producer_url(@other_producer), as: :json, header: @auth_header
    assert_response :unauthorized
  end
  test "Admin can destroy producer" do
    create_producer()
    create_admin()
    delete producer_url(@other_producer), as: :json, header: @auth_header
    assert_response :no_content
    assert @producer.destroyed?
  end
end
