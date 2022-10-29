class Api::TagsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    tags = Tag.all

    render json: { tags: tags.map(&:name) }
  end
end
