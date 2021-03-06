# frozen_string_literal: true

require "refinements/arrays"

module Flacsmith
  module Metadata
    class File
      using Refinements::Arrays

      NUMBER_PATTERN = /\A\d+/

      def initialize path
        @path = String path
      end

      def artist
        String nodes.reverse[2]
      end

      def album
        String nodes.reverse[1]
      end

      def number
        return "" unless last_node
        return "" unless last_node.match? NUMBER_PATTERN

        String(last_node[NUMBER_PATTERN]).rjust 2, "0"
      end

      def title
        String(last_node).gsub(NUMBER_PATTERN, "").gsub(/\..+$/, "").strip
      end

      def name
        [number, title].compress.join " "
      end

      def tags
        [
          Tag.for("TRACKNUMBER", number),
          Tag.for("TITLE", title),
          Tag.for("ALBUM", album),
          Tag.for("ARTIST", artist)
        ]
      end

      def to_s
        path
      end

      alias to_str to_s

      def to_h
        {
          "TRACKNUMBER" => number,
          "TITLE" => title,
          "ALBUM" => album,
          "ARTIST" => artist
        }
      end

      alias to_hash to_h

      private

      attr_reader :path

      def nodes
        to_s.split ::File::SEPARATOR
      end

      def last_node
        nodes.last
      end
    end
  end
end
