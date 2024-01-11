module Articles
  module Forms
    class Create < ::Forms::Base
      attribute :title
      attribute :description
      attribute :body
      attribute :tag_list
    end
  end
end
