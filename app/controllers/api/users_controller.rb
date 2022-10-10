module Api
  class UsersController < ApplicationController
    skip_forgery_protection
    skip_before_action :require_login, only: [:create, :login]

    def create
      create_params = params.require(:user).permit(:email, :username, :password)
      user = User.create!(create_params)

      render json: { user: Users::Serializers::User.new(user, "") }, status: 200
    end

    def login
      login_params = params.require(:user).permit(:email, :password)
      user = User.find_by(email: login_params[:email], password: login_params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base)

      render json: { user: Users::Serializers::User.new(user, token) }, status: 200
    end

    def show
      render json: { user: Users::Serializers::User.new(current_user, "") }, status: 200
    end

    def update
      update_params = params.require(:user).permit(:email)
      current_user.update!(update_params)

      render json: { user: Users::Serializers::User.new(current_user, "") }, status: 200
    end
  end
end
