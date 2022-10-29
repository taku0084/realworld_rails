module Comments
  module Serializers
    class Comment < ::Serializers::Base
      attr_reader :id, :body, :author, :created_at, :updated_at

      # @param [::Comment] comment
      def initialize(comment)
        @id = comment.id
        @body = comment.body
        @author = Users::Serializers::Author.new(comment.author)
        @created_at = format_time(comment.created_at)
        @updated_at = format_time(comment.updated_at)
      end
    end
  end
end
