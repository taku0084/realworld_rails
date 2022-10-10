module Users
  module Serializers
    class User
      include ActiveModel::Serialization

      def initialize(user, token)
        @email = user.email
        @username = user.username
        @bio = user.bio
        @image = user.image
        @token = token
      end

      def attributes
        {
          "email" => @email,
          "username" => @username,
          "bio" => @bio,
          "image" => @image,
          "token" => @token,
        }
      end
    end
  end
end
