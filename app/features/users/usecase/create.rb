module Users
  module Usecase
    class Create
      # @param [Users::Form::Create] form
      def self.run(form)
        user = User.new(email: form.email, username: form.username, password: form.password)
        if user.save
          { user: Users::Serializers::CurrentUser.new(user, "") }
        else
          form.errors.copy!(user.errors)
          form
        end
      end
    end
  end
end
