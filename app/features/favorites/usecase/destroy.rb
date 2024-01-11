module Favorites
  module Usecase
    class Destroy

      # @param [::User] current_user
      # @param [String] article_slug
      def self.run(current_user, article_slug)
        article = Article.find_by!(slug: article_slug)
        ApplicationRecord.transaction do
          Favorite.find_by!(user: current_user, article: article).destroy!
          article.decrement!(:favorites_count)
        end

        { article: Articles::Serializers::Article.new(article, favorited: false) }
      end
    end
  end
end
