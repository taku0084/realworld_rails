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
    before do
      User.create!(email: "test-email", password: "test-password", username: "test")
    end

    describe "success" do
      it "200" do
        params = {
          user: {
            email: "test-email",
            password: "test-password",
          }
        }
        post "/api/users/login", params: params

        assert_response_schema_confirm 200
      end
    end

    describe "login error" do
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

  describe "PUT /api/user" do
    before do
      @user = User.create!(email: "test-email", password: "test-password", username: "test")
    end

    describe "success" do
      it "200" do
        params = {
          user: {
            email: "jake@example.com",
            bio: "I like to skateboard",
            image: "https://i.stack.imgur.com/xHWG8.jpg"
          }
        }
        headers = {
          "Authorization": "Token #{@user.generate_token}"
        }

        put "/api/user", params: params, headers: headers

        @user.reload
        assert_response_schema_confirm 200
        assert_equal "jake@example.com", @user.email
      end
    end

    describe "validation error" do
      it "422" do
        params = {
          user: {
            email: "",
          }
        }
        headers = {
          "Authorization": "Token #{@user.generate_token}"
        }

        put "/api/user", params: params, headers: headers

        @user.reload
        assert_equal 422, response.status
        assert_equal true, response_body.dig("errors", "email").present?
        assert_equal "test-email", @user.email, "not changed"
      end
    end
  end
end
