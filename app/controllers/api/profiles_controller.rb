class Api::ProfilesController < ApplicationController
  skip_forgery_protection

  def show
    user = User.find_by!(username: params[:id])
    following = current_user.follows.where(follow_target_user: user).exists?

    render json: { profile: Users::Serializers::Profile.new(user, following: following) }
  end
end
