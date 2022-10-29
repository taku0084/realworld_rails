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
        @created_at = article.created_at.iso8601(3)
        @updated_at = article.updated_at.iso8601(3)
        @favorited = favorited
        @favorites_count = article.favorites_count
        @author = {
          "username" => nil,
          "bio" => nil,
          "image" => nil,
          "following" => nil
        }
      end
    end
  end
end
