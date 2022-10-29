class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments
end
