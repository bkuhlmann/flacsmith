# frozen_string_literal: true

require "pathname"

module Flacsmith
  module Metadata
    class Builder
      attr_reader :paths

      def initialize path
        @paths = Pathname.glob "#{path.chomp ::File::SEPARATOR}/**/*.flac"
      end

      def build
        files.each { |file| Tagger.new(file).update tags: file.tags }
      end

      private

      def files
        paths.map { |path| File.new path }
      end
    end
  end
end
