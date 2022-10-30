module Api
  class UsersController < ApplicationController
    skip_forgery_protection
    skip_before_action :require_login, only: [:create, :login]

    def create
      create_params = params.require(:user).permit(:email, :username, :password)
      form = Users::Form::Create.new(create_params)
      response = Users::Usecase::Create.run(form)

      render_with response
    end

    def login
      login_params = params.require(:user).permit(:email, :password)
      response = Users::Usecase::Login.run(email: login_params[:email], password: login_params[:password])

      render json: response, status: 200
    end

    def show
      response = Users::Usecase::ShowCurrentUser.run(current_user)

      render json: response, status: 200
    end

    def update
      update_params = params.require(:user).permit(:email)
      response = Users::Usecase::UpdateCurrentUser.run(current_user, update_params[:email])

      render json: response, status: 200
    end
  end
end
