module Users
  module Usecase
    class UpdateCurrentUser
      # @param [::User] current_user
      def self.run(current_user, email)
        current_user.update!(email: email)

        { user: Users::Serializers::CurrentUser.new(current_user, "") }
      end
    end
  end
end
