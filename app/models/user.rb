class User < ApplicationRecord
  has_many :follows
  has_many :articles, foreign_key: "author_id"
  has_many :favorites

  validates :email, presence: true
  validates :username, presence: true
  validates :password, presence: true

  def self.find_by_token(token)
    payload, _headers = JWT.decode token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256"
    User.find(payload["user_id"])
  end

  def generate_token
    JWT.encode({ user_id: id }, Rails.application.credentials.secret_key_base)
  end
end
