class Api::CommentsController < ApplicationController
  skip_forgery_protection

  def create
    article = Article.find_by!(slug: params[:article_id])
    comment = article.comments.create!(body: params[:body], author: current_user)

    render json: { comment: Comments::Serializers::Comment.new(comment) }, status: 200
  end
end
