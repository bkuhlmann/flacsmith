# frozen_string_literal: true

require "pathname"

module Flacsmith
  module Encoders
    # An album encoder for encoding an album of files as FLAC files.
    class Album
      FILE_EXTENSIONS = /\.(aif|aiff)/

      # rubocop:disable Metrics/ParameterLists
      def initialize input_dir:, output_dir: "", image_path: "", track_encoder: Track
        @input_dir = Pathname String(input_dir)
        @output_dir = Pathname String(output_dir)
        @image_path = Pathname String(image_path)
        @track_encoder = track_encoder
      end
      # rubocop:enable Metrics/ParameterLists

      def encode
        input_dir.entries.each do |path|
          next unless path.extname.match? FILE_EXTENSIONS

          track_encoder.new(
            input_path: File.join(input_dir, path),
            image_path: image_path,
            output_dir: output_dir
          ).encode
        end
      end

      private

      attr_reader :input_dir, :output_dir, :image_path, :track_encoder
    end
  end
end
