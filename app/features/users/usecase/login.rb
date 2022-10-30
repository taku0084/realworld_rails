module Users
  module Usecase
    class Login
      def self.run(email:, password:)
        user = User.find_by(email:, password:)

        { user: Users::Serializers::CurrentUser.new(user, user.generate_token) }
      end
    end
  end
end
