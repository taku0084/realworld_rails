module Users
  module Usecase
    class Login
      def self.run(email:, password:)
        user = User.find_by(email:, password:)
        if user.nil?
          raise ::Users::Exceptions::LoginError.new("Failed to Login")
        end

        { user: Users::Serializers::CurrentUser.new(user, user.generate_token) }
      end
    end
  end
end
