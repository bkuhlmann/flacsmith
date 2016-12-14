# frozen_string_literal: true

module Flacsmith
  module Errors
    # The base class for all Flacsmith related errors.
    class Base < StandardError
      def initialize message = "Invalid Flacsmith action."
        super message
      end
    end
  end
end
