module Comments
  module Serializers
    class Comment < ::Serializers::Base
      # @param [::Comment] comment
      def initialize(comment)
        @id = comment.id
        @body = comment.body
        @author = Users::Serializers::Author.new(comment.author)
        @created_at = comment.created_at.iso8601(3)
        @updated_at = comment.updated_at.iso8601(3)
      end

      private

      def attribute_names_for_serialization
        %i[
          id
          body
          author
          created_at
          updated_at
        ]
      end
    end
  end
end
