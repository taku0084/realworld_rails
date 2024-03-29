module Api
  class UsersController < ApplicationController
    skip_forgery_protection
    skip_before_action :require_login, only: [:create, :login]

    def create
      create_params = params.require(:user).permit(:email, :username, :password)
      form = Users::Forms::Create.new(create_params)
      response = Users::Usecase::Create.run(form)

      render_with response, status: 201
    end

    def login
      login_params = params.require(:user).permit(:email, :password)
      response = Users::Usecase::Login.run(email: login_params[:email], password: login_params[:password])

      render_with response
    end

    def show
      response = Users::Usecase::ShowCurrentUser.run(current_user)

      render_with response
    end

    def update
      update_params = params.require(:user).permit(:email, :username, :password, :image, :bio)
      form = Users::Forms::Update.new(update_params)
      response = Users::Usecase::UpdateCurrentUser.run(current_user, form)

      render_with response
    end
  end
end
