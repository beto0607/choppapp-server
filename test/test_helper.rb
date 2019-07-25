ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods

  def createUser
    @user ||= create(:user)
  end

  def createAuthHeader
    createUser()
    @auth_header = { Authorization: "Bearer #{JsonWebToken.encode(user_id: @user.id)}" }
  end

  def createProducer
    createAuthHeader()
    @producer ||= create(:producer, user: @user)
  end
end
