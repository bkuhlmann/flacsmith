# frozen_string_literal: true

require "pathname"
require "open3"
require "shellwords"
require "logger"

module Flacsmith
  module Encoders
    # A track encoder for encoding a file as a FLAC file.
    class Track
      DEFAULT_OPTIONS = ["--verify", %(--picture="<image_path>")].freeze

      # rubocop:disable Metrics/ParameterLists
      def initialize input_path:, image_path: "", output_dir: "", logger: Logger.new(STDOUT)
        @input_path = Pathname String(input_path)
        @picture = Metadata::Image.new image_path
        @output_dir = Pathname String(output_dir)
        @logger = logger
      end
      # rubocop:enable Metrics/ParameterLists

      def encode
        logger.debug { command_line }
        execute_command
        true
      end

      private

      attr_reader :input_path, :picture, :output_dir, :logger

      def substituted_options
        DEFAULT_OPTIONS.map do |option|
          case option
            when /<image_path>/
              option.sub "<image_path>", picture if picture.exist?
            else option
          end
        end
      end

      def tags
        Metadata::File.new(input_path).tags.map { |tag| "--tag=#{tag}" }
      end

      def options
        substituted_options.compact + tags
      end

      def escaped_input_path
        Shellwords.escape input_path
      end

      def output_path
        return Pathname "" unless input_path.exist?

        file = Metadata::File.new input_path
        Pathname.new "#{output_dir}/#{file.name}.flac"
      end

      def escaped_output_path
        Shellwords.escape output_path
      end

      def command_line
        %(flac #{options.join " "} --output-name=#{escaped_output_path} #{escaped_input_path})
      end

      def execute_command
        stdout, stderr, status = Open3.capture3 command_line
        logger.info { stdout }
        fail Errors::Track, stderr unless status.success?
      end
    end
  end
end
