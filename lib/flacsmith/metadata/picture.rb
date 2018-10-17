# frozen_string_literal: true

require "shellwords"

module Flacsmith
  module Metadata
    class Picture
      def initialize path, type: 3, description: "Cover"
        @path = compute_path path
        @type = type
        @description = description
      end

      def dimensions
        ""
      end

      def exist?
        ::File.exist? path
      end

      def to_s
        return "" unless exist?

        [type, "image/jpeg", description, dimensions, path].join "|"
      end

      alias to_str to_s

      private

      attr_reader :path, :type, :description

      def compute_path path
        return "" if String(path).empty?

        Shellwords.escape path
      end
    end
  end
end
