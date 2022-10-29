module Users
  module Serializers
    class User < ::Serializers::Base

      attr_reader :email, :username, :bio, :image, :token

      def initialize(user, token)
        @email = user.email
        @username = user.username
        @bio = user.bio
        @image = user.image
        @token = token
      end
    end
  end
end
