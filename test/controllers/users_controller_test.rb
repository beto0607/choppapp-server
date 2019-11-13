require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Index
  test "should get index" do
    create_admin()
    get users_url, as: :json, headers: @auth_header
    assert_response :ok
  end
  test "shouldn't get index if user isn't a admin" do
    create_auth_header()
    get users_url, as: :json, headers: @auth_header
    assert_response :unauthorized
  end
  test "shouldn't get index if user isn't logged in" do
    get users_url, as: :json
    assert_response :unauthorized
  end

  # Show
  test "should show user" do
    create_user()
    get user_url(@user), as: :json
    assert_response :ok
  end
  test "should return 404 - show" do
    get user_url(-1), as: :json
    assert_response :not_found
  end
  test "shouldn't show info of a private user" do
    create_user()
    @user.update(is_private: true)
    get user_url(@user), as: :json
    assert_response :no_content
  end
  test "should show info of an user itself when is private" do
    create_auth_header()
    @user.update(is_private: true)
    get user_url(@user), as: :json, headers: @auth_header
    assert_response :ok
  end
  # Active
  test "should active user" do
    skip()
    @pending_user = create(:user)
    create_admin()
    patch user_url(@pending_user) + "/active", as: :json, headers: @auth_header
    assert_response :ok
  end
  test "Logged user must be admin - Active" do
    skip()
    @pending_user = create(:user)
    create_auth_header() #Not admin
    patch user_url(@pending_user) + "/active", as: :json, headers: @auth_header
    assert_response :unauthorized
  end

  # Block
  test "should block user" do
    skip()
    @pending_user = create(:user)
    create_admin()
    patch user_url(@pending_user) + "/block", as: :json, headers: @auth_header
    assert_response :ok
  end
  test "Logged user must be admin - Block" do
    skip()
    @pending_user = create(:user)
    create_auth_header() #Not admin
    patch user_url(@pending_user) + "/block", as: :json, headers: @auth_header
    assert_response :unauthorized
  end

  # Delete
  test "should destroy user" do
    create_auth_header()
    delete user_url(@user), as: :json, headers: @auth_header
    assert_response :no_content
    assert @user.destroyed?
  end
  test "should destroy user by admin" do
    create_admin()
    @new_user = create(:user)
    delete user_url(@new_user), as: :json, headers: @auth_header
    assert_response :no_content
    assert @new_user.destroyed?
  end
  test "should return 404 - delete" do
    create_auth_header()
    delete user_url(-1), as: :json, headers: @auth_header
    assert_response :not_found
  end
  test "user logged in must be the user to delete or admin" do
    create_auth_header()
    @new_user = create(:user)
    delete user_url(@new_user), as: :json, headers: @auth_header
    assert_response :forbidden
  end
end
