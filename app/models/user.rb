class User < ApplicationRecord
  has_many :follows
  has_many :articles, foreign_key: "author_id"
  has_many :favorites

  def generate_token
    JWT.encode({ user_id: id }, Rails.application.credentials.secret_key_base)
  end
end
