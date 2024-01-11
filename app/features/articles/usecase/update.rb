module Articles
  module Usecase
    class Update
      def self.run(current_user:, article_slug:, title:, description:, body:)
        article, fav = Article.find_with_fav(current_user, article_slug)
        article.update!({ title:, description:, body: }.compact)

        { article: Articles::Serializers::Article.new(article, favorited: fav) }
      end
    end
  end
end
