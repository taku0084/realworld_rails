module Users
  module Serializers
    class Profile < ::Serializers::Base

      # @param [::User] user
      # @param [Boolean] following
      def initialize(user, following:)
        @username = user.username
        @bio = user.bio
        @image = user.image
        @following = following
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
