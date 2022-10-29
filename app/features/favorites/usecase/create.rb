module Favorites
  module Usecase
    class Create

      # @param [::User] current_user
      # @param [String] article_slug
      def self.run(current_user, article_slug)
        article = Article.find_by!(slug: article_slug)
        ApplicationRecord.transaction do
          Favorite.create!(user: current_user, article: article)
          article.increment!(:favorites_count)
        end

        { article: Articles::Serializers::Article.new(article, favorited: true) }
      end
    end
  end
end
