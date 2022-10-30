require 'test_helper'

module Api
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test "POST /api/users" do
      params = {
        user: {
          email: "test",
          username: "test",
          password: "test",
        }
      }
      post "/api/users", params: params

      assert_equal 200, response.status
    end

    test "POST /api/users validation error" do
      params = {
        user: {
          email: "test",
          username: "test",
          password: "",
        }
      }
      post "/api/users", params: params

      assert_equal 422, response.status
      assert_equal true, response_body.dig("errors", "password").present?
    end
  end
end
