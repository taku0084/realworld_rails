class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments

  before_save :build_slug

  private

  def build_slug
    self.slug = title.downcase.split(/\s+/).join("-")
  end
end
