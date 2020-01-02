# frozen_string_literal: true

module Flacsmith
  module Errors
    class InvalidMetadataKey < Base
      def initialize keys = []
        invalid_keys = Array(keys).join ", "
        valid_keys = Metadata::Tag::KEYS.join ", "

        super %(Invalid metadata key(s): "#{invalid_keys}". Use: "#{valid_keys}".)
      end
    end
  end
end
