module Users
  module Serializers
    class Author < ::Serializers::Base

      attr_reader :username, :bio, :image, :following

      # @param [::User] user
      def initialize(user)
        @username = user.username
        @bio = user.bio || ""
        @image = user.image || ""
        @following = false
      end
    end
  end
end
