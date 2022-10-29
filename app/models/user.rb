class User < ApplicationRecord
  has_many :follows
  has_many :articles, foreign_key: "author_id"
end
