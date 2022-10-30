class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by_token(token)
    end
  end

  def current_user
    @current_user
  end

  def render_with(resource, **options)
    if resource.respond_to?(:errors) && !resource.errors.empty?
      render json: { errors: resource.errors }, status: 422
    else
      render json: resource, **options
    end
  end
end
