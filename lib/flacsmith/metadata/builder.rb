# frozen_string_literal: true

require "refinements/pathnames"

module Flacsmith
  module Metadata
    class Builder
      using Refinements::Pathnames

      attr_reader :paths

      def initialize path
        @paths = path.files "**/*.flac"
      end

      def build
        files.each { |file| Tagger.new(file).update file.tags }
      end

      private

      def files
        paths.map { |path| File.new path }
      end
    end
  end
end
