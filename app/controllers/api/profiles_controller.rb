class Api::ProfilesController < ApplicationController
  def show
    user = User.find_by!(username: params[:id])

    render json: { profile: Users::Serializers::Profile.new(user) }
  end
end
