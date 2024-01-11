class Api::FollowsController < ApplicationController
  skip_forgery_protection

  def create
    user = User.find_by!(username: params[:profile_id])
    current_user.follows.create!(follow_target_user: user)

    render json: { profile: Users::Serializers::Profile.new(user, following: true) }
  end

  def destroy
    user = User.find_by!(username: params[:profile_id])
    current_user.follows.find_by!(follow_target_user: user).destroy!

    render json: { profile: Users::Serializers::Profile.new(user, following: false) }
  end
end
