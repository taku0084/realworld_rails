module Articles
  module Usecase
    class Create
      # @param [::User] current_user
      # @param [::Articles::Forms::Create] form
      def self.run(current_user, form)
        ApplicationRecord.transaction do
          # TODO: tag validation error
          tags = form.tag_list.map { |tag_name| Tag.find_or_create_by!(name: tag_name) }
          article = Article.new(title: form.title, description: form.description, body: form.body, author: current_user)
          article.tags += tags.sort_by(&:name)
          if article.save
            { article: Articles::Serializers::Article.new(article, favorited: false) }
          else
            form.errors.copy!(article.errors)
            form
          end
        end
      end
    end
  end
end
