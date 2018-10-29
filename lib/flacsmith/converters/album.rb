# frozen_string_literal: true

require "pathname"

module Flacsmith
  module Converters
    # An album converter for converting an album of files into FLAC files.
    class Album
      FILE_EXTENSIONS = /\.(aif|aiff)/.freeze

      # rubocop:disable Metrics/ParameterLists
      def initialize input_dir:, output_dir: "", picture_path: "", track_converter: Track
        @input_dir = Pathname String(input_dir)
        @output_dir = Pathname String(output_dir)
        @picture_path = Pathname String(picture_path)
        @track_converter = track_converter
      end
      # rubocop:enable Metrics/ParameterLists

      def convert
        input_dir.entries.each do |path|
          next unless path.extname.match?(FILE_EXTENSIONS)

          track_converter.new(
            input_path: File.join(input_dir, path),
            picture_path: picture_path,
            output_dir: output_dir
          ).convert
        end
      end

      private

      attr_reader :input_dir, :output_dir, :picture_path, :track_converter
    end
  end
end
