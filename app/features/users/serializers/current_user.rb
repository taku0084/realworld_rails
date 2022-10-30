module Users
  module Serializers
    class CurrentUser < ::Serializers::Base

      attr_reader :email, :username, :bio, :image, :token, :password

      def initialize(user, token)
        @email = user.email
        @username = user.username
        @bio = user.bio || ""
        @image = user.image || ""
        @token = token
        @password = ""
      end
    end
  end
end
