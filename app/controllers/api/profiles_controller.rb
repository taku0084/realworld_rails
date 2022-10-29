class Api::ProfilesController < ApplicationController
  skip_forgery_protection

  def show
    user = User.find_by!(username: params[:id])
    following = current_user.follows.where(follow_target_user: user).exists?

    render json: { profile: Users::Serializers::Profile.new(user, following: following) }
  end

  def follow
    user = User.find_by!(username: params[:id])
    current_user.follows.create!(follow_target_user: user)

    render json: { profile: Users::Serializers::Profile.new(user, following: true) }
  end

  def unfollow
    user = User.find_by!(username: params[:id])
    current_user.follows.find_by!(follow_target_user: user).destroy!

    render json: { profile: Users::Serializers::Profile.new(user, following: false) }
  end
end
