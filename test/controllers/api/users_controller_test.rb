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
end
