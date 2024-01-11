class Api::FavoritesController < ApplicationController
  skip_forgery_protection

  def create
    response = Favorites::Usecase::Create.run(current_user, params[:article_id])

    render json: response, status: 200
  end

  def destroy
    response = Favorites::Usecase::Destroy.run(current_user, params[:article_id])

    render json: response, status: 200
  end
end
