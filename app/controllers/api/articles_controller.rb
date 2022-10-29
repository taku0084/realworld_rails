class Api::ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  skip_forgery_protection

  def index
    articles =
      if (tag = params[:tag])
        Article.joins(:tags).where(article_tags: { tags: { name: tag } })
      else
        Article.all
      end
    articles_response = articles.map { |article| Articles::Serializers::Article.new(article, favorited: false) }

    render json: { articles: articles_response, articlesCount: articles_response.size }, status: 200
  end

  def create
    create_params = params.require(:article).permit(:title, :description, :body, tag_list: [])

    article = ApplicationRecord.transaction do
      tags = create_params[:tag_list].map { |tag_name| Tag.find_or_create_by!(name: tag_name) }
      slug = create_params[:title].downcase.split(/\s+/).join("-")
      article = Article.create!(create_params.slice(:title, :description, :body).merge(slug: slug))
      article.tags += tags.sort_by(&:name)
      article
    end
    render json: { article: Articles::Serializers::Article.new(article, favorited: false) }, status: 200
  end

  def show
    slug = params[:id]
    article = Article.find_by(slug: slug)

    render json: { article: Articles::Serializers::Article.new(article, favorited: false) }, status: 200
  end

  def feed
    articles = []
    articles_response = articles.map { |article| Articles::Serializers::Article.new(article, favorited: false) }

    render json: { articles: articles_response, articlesCount: articles_response.size }, status: 200
  end

  def update
    slug = params[:id]
    article = Article.find_by!(slug: slug)
    update_params = params.permit(:title, :description, :body)
    article.attributes = update_params
    article.slug = article.title.downcase.split(/\s+/).join("-")
    article.save!

    render json: { article: Articles::Serializers::Article.new(article, favorited: false) }, status: 200
  end

  def favorite
    article = Article.find_by!(slug: params[:id])
    ApplicationRecord.transaction do
      Favorite.create!(user: current_user, article: article)
      article.increment!(:favorites_count)
    end

    render json: { article: Articles::Serializers::Article.new(article, favorited: true) }, status: 200
  end

  def unfavorite
    article = Article.find_by!(slug: params[:id])
    ApplicationRecord.transaction do
      Favorite.find_by!(user: current_user, article: article).destroy!
      article.decrement!(:favorites_count)
    end

    render json: { article: Articles::Serializers::Article.new(article, favorited: false) }, status: 200
  end
end
