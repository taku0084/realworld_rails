module Articles
  module Usecase
    class Create
      def self.run(current_user:, title:, description:, body:, tag_list:)
        article = ApplicationRecord.transaction do
          tags = tag_list.map { |tag_name| Tag.find_or_create_by!(name: tag_name) }
          article = Article.create!({ title:, description:, body: }.merge(author: current_user))
          article.tags += tags.sort_by(&:name)
          article
        end

        { article: Articles::Serializers::Article.new(article, favorited: false) }
      end
    end
  end
end
