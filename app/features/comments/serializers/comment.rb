module Comments
  module Serializers
    class Comment < ::Serializers::Base
      attr_reader :id, :body, :author, :created_at, :updated_at

      # @param [::Comment] comment
      def initialize(comment)
        @id = comment.id
        @body = comment.body
        @author = Users::Serializers::Author.new(comment.author)
        @created_at = comment.created_at.iso8601(3)
        @updated_at = comment.updated_at.iso8601(3)
      end
    end
  end
end
