require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  describe "POST /api/users" do
    describe "success" do
      it "200" do
        params = {
          user: {
            email: "test",
            username: "test",
            password: "test",
          }
        }
        post "/api/users", params: params

        assert_response_schema_confirm 201
      end
    end

    describe "validation error" do
      it "422" do
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

  describe "POST /api/users/login" do
    describe "login error" do
      before do
        User.create!(email: "test-email", password: "test-password", username: "test")
      end

      it "400" do
        params = {
          user: {
            email: "test-email",
            password: "invalid-password",
          }
        }
        post "/api/users/login", params: params

        assert_equal 400, response.status
        assert_equal "Failed to Login", response_body.dig("errors", "body")
      end
    end
  end
end
