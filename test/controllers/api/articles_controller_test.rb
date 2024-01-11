require "test_helper"

class Api::ArticlesControllerTest < ActionDispatch::IntegrationTest
  describe "POST /api/articles" do
    before do
      @user = User.create!(email: "test-email", password: "test-password", username: "test")
    end

    describe "valid parameter" do
      it "200" do
        params = {
          article: {
            title: "title",
            description: "description",
            body: "body",
            tag_list: ["tag1", "tag2"],
          }
        }
        post "/api/articles", params: params, headers: { "Authorization": "Token #{@user.generate_token}" }

        assert_response_schema_confirm 201
      end
    end

    describe "invalid parameter" do
      it "422" do
        params = {
          article: {
            title: "",
            description: "description",
            body: "body",
            tag_list: ["tag1", "tag2"],
          }
        }
        post "/api/articles", params: params, headers: { "Authorization": "Token #{@user.generate_token}" }

        assert_equal 422, response.status
        assert_equal true, response_body.dig("errors", "title").present?
      end
    end
  end
end
