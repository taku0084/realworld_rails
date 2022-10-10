class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    authenticate_or_request_with_http_token do |token, _options|
      payload, headers = JWT.decode token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256"
      @current_user = User.find(payload["user_id"])
    end
  end

  def current_user
    @current_user
  end
end
