ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods

  def create_user
    @user = create(:user)
  end

  def create_auth_header
    create_user()
    @auth_header = { Authorization: "Bearer #{JsonWebToken.encode(user_id: @user.id)}" }
  end

  def create_producer
    create_auth_header()
    @producer = create(:producer, user: @user)
  end

  def create_admin
    create_auth_header()
    @user.update(is_admin: true)
  end
end
