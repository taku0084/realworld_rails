module Articles
  module Serializers
    class Article < ::Serializers::Base

      attr_reader :slug, :title, :description, :body, :tag_list, :created_at, :updated_at, :favorited, :favorites_count, :author

      # @param [::Article] article
      # @param [Boolean] favorited
      def initialize(article, favorited:)
        @slug = article.slug
        @title = article.title
        @description = article.description
        @body = article.body
        @tag_list = article.tags.map(&:name)
        @created_at = format_time(article.created_at)
        @updated_at = format_time(article.updated_at)
        @favorited = favorited
        @favorites_count = article.favorites_count
        @author = Users::Serializers::Author.new(article.author)
      end
    end
  end
end
