# frozen_string_literal: true

module Flacsmith
  module Metadata
    class Formatter
      def initialize text
        @text = String text
      end

      def to_h
        text.split("\n").reduce({}) do |new_hash, line|
          key, value = line.split "="
          new_hash.merge key => value
        end
      end

      private

      attr_reader :text
    end
  end
end
