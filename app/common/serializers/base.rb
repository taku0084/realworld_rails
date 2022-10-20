module Serializers
  class Base
    include ActiveModel::Serializers::JSON

    def read_attribute_for_serialization(key)
      instance_variable_get("@#{key}")
    end

    def serializable_hash(...)
      hash = super
      hash.deep_transform_keys! { _1.to_s.camelcase(:lower) }
    end
  end
end
