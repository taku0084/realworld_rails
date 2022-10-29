class Api::FavoritesController < ApplicationController
  skip_forgery_protection

  def create
    article = Article.find_by!(slug: params[:article_id])
    ApplicationRecord.transaction do
      Favorite.create!(user: current_user, article: article)
      article.increment!(:favorites_count)
    end

    render json: { article: Articles::Serializers::Article.new(article, favorited: true) }, status: 200
  end

  def destroy
    article = Article.find_by!(slug: params[:article_id])
    ApplicationRecord.transaction do
      Favorite.find_by!(user: current_user, article: article).destroy!
      article.decrement!(:favorites_count)
    end

    render json: { article: Articles::Serializers::Article.new(article, favorited: false) }, status: 200
  end
end
