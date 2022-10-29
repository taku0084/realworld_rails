module Users
  module Usecase
    class Create
      def self.run(email:, username:, password:)
        user = User.create!(email:, username:, password:)

        { user: Users::Serializers::User.new(user, user.generate_token) }
      end
    end
  end
end
