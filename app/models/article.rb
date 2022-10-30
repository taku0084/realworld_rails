class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments

  before_save :build_slug

  validates :title, presence: true
  validates :description, presence: true
  validates :body, presence: true

  # @param [::User] user
  def self.find_with_fav(user, slug)
    article = Article.find_by!(slug: slug)
    favorite = user.present? && user.favorites.where(article: article).exists?

    [article, favorite]
  end

  private

  def build_slug
    self.slug = title.downcase.split(/\s+/).join("-")
  end
end
