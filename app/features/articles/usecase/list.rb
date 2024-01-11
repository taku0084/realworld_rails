module Articles
  module Usecase
    class List

      # @param [::User] current_user
      # @param [String] tag
      def self.run(current_user, tag)
        articles =
          if tag
            Article.joins(:tags).where(article_tags: { tags: { name: tag } })
          else
            Article.all
          end

        if current_user
          favorites = current_user.favorites.where(articles: articles).index_by(&:article_id)
        else
          favorites = {}
        end

        articles = articles.map { |article| ::Articles::Serializers::Article.new(article, favorited: favorites[article.id]) }
        articles_count = articles.size

        { articles: articles, articlesCount: articles_count }
      end
    end
  end
end
