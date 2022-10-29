module Users
  module Usecase
    class ShowCurrentUser

      # @param [::User] current_user
      def self.run(current_user)
        { user: Users::Serializers::User.new(current_user, "") }
      end
    end
  end
end
