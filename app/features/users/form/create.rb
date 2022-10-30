module Users
  module Form
    class Create
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :email, :string
      attribute :username, :string
      attribute :password, :string
    end
  end
end
