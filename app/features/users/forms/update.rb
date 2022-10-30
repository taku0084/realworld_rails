module Users
  module Forms
    class Update
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :email, :string
      attribute :username, :string
      attribute :password, :string
      attribute :image, :string
      attribute :bio, :string
    end
  end
end
