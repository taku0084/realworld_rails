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
    article = Articles::Service::Create.run(current_user: current_user, **create_params.to_h.symbolize_keys)

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
    update_params = params.require(:article).permit(:title, :description, :body)
    response = Articles::Usecase::Update.run(
      current_user:, article_slug: params[:id],
      title: update_params[:title], description: update_params[:description], body: update_params[:body])

    render json: response, status: 200
  end
end
