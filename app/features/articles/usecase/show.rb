module Articles
  module Usecase
    class Show

      # @param [::User] current_user
      # @param [String] slug
      def self.run(current_user, slug)
        article, fav = Article.find_with_fav(current_user, slug)

        { article: Articles::Serializers::Article.new(article, favorited: fav) }
      end
    end
  end
end
