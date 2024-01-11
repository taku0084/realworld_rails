class Api::CommentsController < ApplicationController
  skip_forgery_protection
  skip_before_action :require_login, only: [:index]

  def index
    article = Article.find_by!(slug: params[:article_id])
    comment = article.comments
    comments_response = article.comments.map { |comment| Comments::Serializers::Comment.new(comment) }

    render json: { comments: comments_response }
  end

  def create
    article = Article.find_by!(slug: params[:article_id])
    comment = article.comments.create!(body: params[:body], author: current_user)

    render json: { comment: Comments::Serializers::Comment.new(comment) }, status: 200
  end
end
