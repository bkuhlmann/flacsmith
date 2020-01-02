# frozen_string_literal: true

module Flacsmith
  module Metadata
    class Tagger
      def initialize path
        @path = path
      end

      def read tags = Tag.defaults
        options = Array(tags).map { |tag| "--show-tag=#{tag.key}" }
        Formatter.new(`metaflac #{options.join " "} "#{path}" 2> /dev/null`).to_h
      end

      def add tags = []
        options = Array(tags).map { |tag| "--set-tag=#{tag}" }
        Formatter.new(`metaflac #{options.join " "} "#{path}" 2> /dev/null`).to_h
      end

      def remove tags = []
        options = Array(tags).map { |tag| "--remove-tag=#{tag.key}" }
        Formatter.new(`metaflac #{options.join " "} "#{path}" 2> /dev/null`).to_h
      end

      def update tags = []
        remove tags
        add tags
      end

      private

      attr_reader :path
    end
  end
end
