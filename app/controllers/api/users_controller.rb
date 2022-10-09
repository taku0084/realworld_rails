module Api
  class UsersController < ApplicationController
    skip_forgery_protection

    def create
      user = User.create!(user_params)
      render json: { user: user.as_json(only: [:email, :username, :bio, :image]).merge(token: "") }, status: 200
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :password)
    end
  end
end
