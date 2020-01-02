# frozen_string_literal: true

require "shellwords"

module Flacsmith
  module Metadata
    class Tag
      KEYS = %w[
        ALBUM
        ARTIST
        CONTACT
        COPYRIGHT
        DATE
        DESCRIPTION
        GENRE
        ISRC
        LICENSE
        LOCATION
        ORGANIZATION
        PERFORMER
        TITLE
        TRACKNUMBER
        VERSION
      ].freeze

      attr_reader :key

      def self.defaults
        KEYS.map { |key| self.for key }
      end

      def self.for key, value = ""
        new key, value
      end

      def initialize key, initial_value = ""
        @key = key
        @initial_value = String initial_value
        validate
      end

      def value
        return initial_value if initial_value.empty?

        Shellwords.escape initial_value
      end

      def to_s
        "#{key}=#{value}"
      end

      alias to_str to_s

      private

      attr_reader :initial_value

      def validate
        invalid_keys = [key] - KEYS
        return true if invalid_keys.empty?

        fail Errors::InvalidMetadataKey, invalid_keys
      end
    end
  end
end
