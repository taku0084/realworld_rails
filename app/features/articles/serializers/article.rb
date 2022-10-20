module Articles
  module Serializers
    class Article < ::Serializers::Base

      # @param [::Article] article
      def initialize(article)
        @slug = article.slug
        @title = article.title
        @description = article.description
        @body = article.body
        @tag_list = article.tags.map(&:name)
        @created_at = article.created_at.iso8601(3)
        @updated_at = article.updated_at.iso8601(3)
        @favorited = nil
        @favorites_count = 0
        @author = {
          "username" => nil,
          "bio" => nil,
          "image" => nil,
          "following" => nil
        }
      end

      def attribute_names_for_serialization
        %i[
          slug
          title
          description
          body
          tag_list
          created_at
          updated_at
          favorited
          favorites_count
          author
        ]
      end
    end
  end
end
