module Users
  module Usecase
    class UpdateCurrentUser
      # @param [::User] current_user
      # @param [::Users::Form::Update] form
      def self.run(current_user, form)
        if current_user.update(form.attributes.compact)
          { user: Users::Serializers::CurrentUser.new(current_user, "") }
        else
          form.errors.copy!(current_user.errors)
          form
        end
      end
    end
  end
end
