# frozen_string_literal: true

require "thor"
require "thor/actions"
require "pathname"

module Flacsmith
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity::VERSION_LABEL

    # Initialize.
    def initialize args = [], options = {}, config = {}
      super args, options, config
    end

    desc "-e, [--encode=INPUT_DIR OUTPUT_DIR]", "Encode source audio as FLAC audio."
    map %w[-e --encode] => :encode
    method_option :image,
                  aliases: "-i",
                  desc: "File path to album image.",
                  type: :string,
                  default: ""
    def encode input_dir, output_dir
      say "Encoding: #{input_dir} to #{output_dir}...\n\n"
      encoder = Encoders::Album.new input_dir: input_dir,
                                    output_dir: output_dir,
                                    image_path: options.image
      encoder.encode
      say "Audio encoded."
    end

    desc "-l, [--list=PATH]", "List track metadata for given folder/file structure."
    map %w[-l --list] => :list
    def list path
      say "Listing metadata for: #{path}...\n\n"
      print_metadata path
      say "Metadata list complete."
    end

    desc "-r, [--rebuild=PATH]", "Rebuild track metadata for given folder/file structure."
    map %w[-r --rebuild] => :rebuild
    # :reek:TooManyStatements
    def rebuild path
      say "Rebuilding metadata for: #{path}..."

      metadata = Metadata::Builder.new path
      metadata.build
      metadata.paths.each { |file_path| say "Processed: #{file_path}" }

      say "Metadata rebuilt."
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity::VERSION_LABEL
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    def print_tags path
      Metadata::Tagger.new(path).read.map { |key, value| say "#{key} = #{value}" }
    end

    def print_metadata path
      Pathname.glob("#{path}/**/*.flac").each do |file_path|
        say "FILE = #{file_path}"
        print_tags file_path
        say
      end
    end
  end
end
