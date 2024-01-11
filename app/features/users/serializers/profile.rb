module Users
  module Serializers
    class Profile < ::Serializers::Base

      attr_reader :username, :bio, :image, :following

      # @param [::User] user
      # @param [Boolean] following
      def initialize(user, following:)
        @username = user.username
        @bio = user.bio
        @image = user.image
        @following = following
      end
    end
  end
end
