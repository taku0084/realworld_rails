module Articles
  module Usecase
    class Update
      def self.run(current_user:, article_slug:, title:, description:, body:)
        article = current_user.articles.find_by!(slug: article_slug)
        article.update!({ title:, description:, body: }.compact)

        { article: Articles::Serializers::Article.new(article, favorited: false) }
      end
    end
  end
end
