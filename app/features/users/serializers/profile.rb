module Users
  module Serializers
    class Profile < ::Serializers::Base

      # @param [::User] user
      def initialize(user)
        @username = user.username
        @bio = user.bio
        @image = user.image
        @following = false
      end

      private

      def attribute_names_for_serialization
        %i[
          username
          bio
          image
          following
        ]
      end
    end
  end
end
